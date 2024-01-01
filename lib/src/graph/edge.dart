part of './graph.dart';

class PortTypeException {
  Port fromPort;
  Port toPort;

  PortTypeException({required this.fromPort, required this.toPort});

  String get message =>
      "Incompatible port tpyes: From ${fromPort.runtimeType} to ${toPort.runtimeType}";
}

class Edge<FromDataType extends ToDataType, ToDataType> {
  final OutPort<FromDataType, Node> from;
  final InPort<ToDataType, Node> to;

  Edge._(this.from, this.to);

  /// A static method is used as a factory instead of an actual factory method
  /// This is to allow for generic type definition, which is used to ensure
  /// [FromDataType] can be converted to [ToDataType] in type analysis
  factory Edge.connect(
      OutPort<FromDataType, Node> from, InPort<ToDataType, Node> to) {
    // Create edge
    final edge = Edge._(from, to);

    if (!to.canAccept(from)) {
      throw PortTypeException(fromPort: from, toPort: to);
    }

    // Call connect on both sides
    to._connectTo(edge);
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
