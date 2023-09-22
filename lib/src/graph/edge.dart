part of './graph.dart';

class Edge<T> {
  final OutPort<T> from;
  final InPort<T> to;

  Edge._create(this.from, this.to);

  void disconnect() {
    from._disconnect(this);
    to._disconnect();
  }
}
