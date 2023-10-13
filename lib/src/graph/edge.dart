part of './graph.dart';

class Edge<DataType> {
  final OutPort<DataType, Node> from;
  final InPort<DataType, Node> to;

  Edge._create(this.from, this.to);

  /// Disconnect this edge
  void disconnect() {
    // Notify nodes of the disconnection
    from._disconnect(this);
    to._disconnect();

    // Send disconnected event
    final disconnectedEventStream = from.node.graph._onEdgeDisconnectedController;
    if(disconnectedEventStream.hasListener) {
      disconnectedEventStream.add(this);
    }
  }
}
