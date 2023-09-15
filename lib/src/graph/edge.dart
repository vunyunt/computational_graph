part of './graph.dart';

class Edge<T> {
  final OutPort<T> from;
  final InPort<T> to;
  late final StreamSubscription<T> subscription;

  Edge(this.from, this.to) {
    subscription = from.stream.listen(to.onData);

    from._connectTo(this);
    to._connectTo(this);
  }

  void disconnect() {
    subscription.cancel();
    from._disconnect(this);
    to._disconnect();
  }
}
