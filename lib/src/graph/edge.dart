part of './graph.dart';

class Edge<DataType> {
  final OutPort<DataType, Node> from;
  final InPort<DataType, Node> to;

  Edge._create(this.from, this.to);

  void disconnect() {
    from._disconnect(this);
    to._disconnect();
  }
}
