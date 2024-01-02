part of 'graph.dart';

class UnregisteredPortError extends Error {}

abstract class Node extends HasId with HasSerializableAttributes {
  final Graph graph;

  final Map<String, InPort> _inPorts = {};
  final Map<String, OutPort> _outPorts = {};

  late final UnmodifiableMapView<String, InPort> inPorts;
  late final UnmodifiableMapView<String, OutPort> outPorts;

  /// Name of the node's type. This is used to identify the node's class type
  /// in serialization.
  String get typeName;

  /// [id] must be unique to the graph this node belongs to. If it's not passed
  /// in, a uuid will be generated.
  Node(this.graph, {String? id}) : super(id) {
    for (final inPort in createInPorts()) {
      _inPorts[inPort.name] = inPort;
    }
    for (final outPort in createOutPorts()) {
      _outPorts[outPort.name] = outPort;
    }

    inPorts = UnmodifiableMapView(_inPorts);
    outPorts = UnmodifiableMapView(_outPorts);

    graph.nodes[this.id] = this;

    portsCreated();
  }

  Iterable<InPort> createInPorts();
  Iterable<OutPort> createOutPorts();

  /// Implementing class should override this if it needs to process ports after
  /// they are created
  void portsCreated() {}

  @protected
  void sendTo<DataType, NodeType extends Node>(
      OutPort<DataType, NodeType> port, DataType value) {
    if (!_outPorts.containsKey(port.name) || _outPorts[port.name] != port) {
      throw UnregisteredPortError();
    }

    port._send(value);
  }

  /// Open the given [OutPort], making it ready to receive it value.
  @protected
  void open<DataType, NodeType extends Node>(OutPort<DataType, NodeType> port) {
    if (!_outPorts.containsKey(port.name) || _outPorts[port.name] != port) {
      throw UnregisteredPortError();
    }

    port._open();
  }

  /// Close the given [OutPort], signalling receiving ends of the closure.
  @protected
  void close<DataType, NodeType extends Node>(
      OutPort<DataType, NodeType> port) {
    if (!_outPorts.containsKey(port.name) || _outPorts[port.name] != port) {
      throw UnregisteredPortError();
    }

    port._close();
  }
}
