part of './graph.dart';

class Edge<FromDataType extends ToDataType, ToDataType> {
  final OutPort<FromDataType, Node> from;
  final InPort<ToDataType, Node> to;

  Edge._(this.from, this.to);

  /// A static method is used as a factory instead of an actual factory method
  /// This is to allow for generic type definition, which is used to ensure
  /// [FromDataType] can be converted to [ToDataType] in type analysis
  ///
  /// In addition, [from.exampleValue] is used to perform a test to ensure [to]
  /// can actually accept the value type [FromDataType] as input during runtime
  factory Edge.connect(
      OutPort<FromDataType, Node> from, InPort<ToDataType, Node> to) {
    // Create edge
    final edge = Edge._(from, to);

    // Call connect on both sides
    to._connectTo(edge, from.exampleValue);
    from._connectTo(edge);

    return edge;
  }

  /// Disconnect this edge
  void disconnect() {
    // Notify nodes of the disconnection
    from._disconnect(this);
    to._disconnect();

    // Send disconnected event
    final disconnectedEventStream =
        from.node.graph._onEdgeDisconnectedController;
    if (disconnectedEventStream.hasListener) {
      disconnectedEventStream.add(this);
    }
  }
}
