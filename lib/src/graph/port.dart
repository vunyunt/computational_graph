part of './graph.dart';

class PortStateError extends Error {
  String message;

  PortStateError({this.message = ""});
}

abstract class Port<DataType> {
  final Node node;

  /// Name of the port. This should be unique within the same node.
  final String name;
  bool get isOpen;
  bool get connected;

  Port({required this.node, required this.name});
}

class InPort<T> extends Port<T> {
  Edge<T>? _edge;
  @override
  bool get connected => _edge != null;
  Edge<T>? get edge => _edge;
  StreamController<T>? _currentDataStream;
  final Function(Stream<T>) onDataStreamAvailable;

  @override
  bool get isOpen =>
      _currentDataStream != null && !_currentDataStream!.isClosed;

  InPort(
      {required super.node,
      required super.name,
      required this.onDataStreamAvailable});

  void _connectTo(Edge<T> edge) {
    _edge = edge;
  }

  void _disconnect() {
    _edge = null;
  }

  void _receive(T value) {
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

class OutPort<T> extends Port<T> {
  final Set<Edge<T>> _edges = {};
  late final UnmodifiableSetView<Edge<T>> edges;
  bool _isOpen = false;

  @override
  bool get isOpen => _isOpen;

  OutPort({required super.node, required super.name}) {
    edges = UnmodifiableSetView(_edges);
  }

  void _disconnect(Edge<T> edge) {
    _edges.remove(edge);
  }

  Edge<T> connectTo(InPort<T> other) {
    var edge = Edge<T>._create(this, other);
    edge.to._connectTo(edge);

    if (_isOpen) {
      edge.to._open();
    }

    _edges.add(edge);

    return edge;
  }

  void _send(T value) {
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
