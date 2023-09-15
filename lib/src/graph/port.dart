part of './graph.dart';

abstract class Port<DataType> {
  final Node node;

  Port(this.node);
}

class InPort<T> extends Port<T> {
  Edge<T>? _edge;
  bool connected() => _edge != null;
  late final Function(T) onData;

  InPort(super.node, this.onData);

  Edge<T> connectTo(OutPort<T> other) {
    return Edge<T>(other, this);
  }

  void _connectTo(Edge<T> edge) {
    _edge = edge;
  }

  void disconnect() {
    _edge?.disconnect();
  }

  void _disconnect() {
    _edge = null;
  }
}

class OutPort<T> extends Port<T> {
  final Set<Edge<T>> _edges = {};
  late final UnmodifiableSetView<Edge<T>> edges;
  final StreamController<T> _streamController = StreamController.broadcast();
  late final Stream<T> stream;

  OutPort(super.node) {
    edges = UnmodifiableSetView(_edges);
    stream = _streamController.stream;
  }

  void _disconnect(Edge<T> edge) {
    _edges.remove(edge);
  }

  Edge<T> connectTo(InPort<T> other) {
    return Edge<T>(this, other);
  }

  void _connectTo(Edge<T> edge) {
    _edges.add(edge);
  }

  void _send(T value) {
    if (_streamController.hasListener) {
      _streamController.add(value);
    }
  }

  bool connected() => _edges.isNotEmpty && _streamController.hasListener;
}
