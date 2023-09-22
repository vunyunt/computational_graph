part of 'graph.dart';

class UnregisteredPortError extends Error {}

abstract class Node extends HasId {
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
    createPorts(_inPorts, _outPorts);

    inPorts = UnmodifiableMapView(_inPorts);
    outPorts = UnmodifiableMapView(_outPorts);

    graph.nodes[this.id] = this;
  }

  void createPorts(Map<String, InPort> inPorts, Map<String, OutPort> outPorts);

  @protected
  void sendTo<T>(OutPort<T> port, T value) {
    if (!_outPorts.containsKey(port.name) || _outPorts[port.name] != port) {
      throw UnregisteredPortError();
    }

    port._send(value);
  }

  /// Open the given [OutPort], making it ready to receive it value.
  @protected
  void open<T>(OutPort<T> port) {
    if (!_outPorts.containsKey(port.name) || _outPorts[port.name] != port) {
      throw UnregisteredPortError();
    }

    port._open();
  }

  /// Close the given [OutPort], signalling receiving ends of the closure.
  @protected
  void close<T>(OutPort<T> port) {
    if (!_outPorts.containsKey(port.name) || _outPorts[port.name] != port) {
      throw UnregisteredPortError();
    }

    port._close();
  }
}
