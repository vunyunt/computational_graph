part of './graph.dart';

class PortStateError extends Error {
  String message;

  PortStateError({this.message = ""});
}

abstract class Port<DataType, NodeType extends Node> {
  final NodeType node;

  /// Name of the port. This should be unique within the same node.
  final String name;
  bool get isOpen;
  bool get connected;

  Port({required this.node, required this.name});
}

class InPort<DataType, NodeType extends Node> extends Port<DataType, NodeType> {
  Edge<DataType>? _edge;
  @override
  bool get connected => _edge != null;
  Edge<DataType>? get edge => _edge;
  StreamController<DataType>? _currentDataStream;
  final Function(Stream<DataType>) onDataStreamAvailable;

  @override
  bool get isOpen =>
      _currentDataStream != null && !_currentDataStream!.isClosed;

  InPort(
      {required super.node,
      required super.name,
      required this.onDataStreamAvailable});

  /// Connect to an edge. Intended to be called by [OutPort.connectTo]
  void _connectTo<FromNodeType extends Node>(Edge<DataType> edge) {
    // Disconnect the current edge first, since InPort can only have one edge at
    // a time.
    if (_edge != null) {
      _edge!.disconnect();
    }

    _edge = edge;
  }

  void _disconnect() {
    _edge = null;
  }

  void _receive(DataType value) {
    if (_currentDataStream == null) {
      throw PortStateError(message: "A Closed InPort received a value.");
    }

    if (_currentDataStream!.hasListener) {
      _currentDataStream!.add(value);
    }
  }

  void _open() {
    _currentDataStream = StreamController();
    onDataStreamAvailable(_currentDataStream!.stream);
  }

  void _close() {
    _currentDataStream?.close();
    _currentDataStream = null;
  }
}

class OutPort<DataType, NodeType extends Node>
    extends Port<DataType, NodeType> {
  final Set<Edge<DataType>> _edges = {};
  late final UnmodifiableSetView<Edge<DataType>> edges;
  bool _isOpen = false;

  @override
  bool get isOpen => _isOpen;

  /// Create an output port. Also opens this port if [open] is true (default)
  OutPort({required super.node, required super.name, open = true}) {
    edges = UnmodifiableSetView(_edges);

    if (open) {
      this._open();
    }
  }

  void _disconnect(Edge<DataType> edge) {
    _edges.remove(edge);
  }

  /// Connect to the specified [InPort]. Currently edges can only be initiated
  /// from [OutPort]s.
  Edge<DataType> connectTo<ToNodeType extends Node>(
      InPort<DataType, ToNodeType> other) {
    // Create edge
    var edge = Edge<DataType>._create(this, other);

    // Call connect on the other side
    edge.to._connectTo(edge);

    // Open the InPort connected to this if this port is open
    if (_isOpen) {
      edge.to._open();
    }

    // Send connected event
    if (node.graph._onEdgeConnectedController.hasListener) {
      node.graph._onEdgeConnectedController.add(edge);
    }

    // Record the connection
    _edges.add(edge);

    return edge;
  }

  void _send(DataType value) {
    for (var edge in _edges) {
      edge.to._receive(value);
    }
  }

  @override
  bool get connected => _edges.isNotEmpty;

  void _close() {
    _isOpen = false;

    for (var edge in _edges) {
      edge.to._close();
    }
  }

  void _open() {
    _isOpen = true;

    for (var edge in _edges) {
      edge.to._open();
    }
  }
}
