part of 'graph.dart';

abstract class Node {
  final Graph graph;

  final Set<InPort> _inPorts = {};
  final Set<OutPort> _outPorts = {};

  late final UnmodifiableSetView<InPort> inPorts;
  late final UnmodifiableSetView<OutPort> outPorts;

  Node(this.graph) {
    registerPorts(_inPorts, _outPorts);

    inPorts = UnmodifiableSetView(_inPorts);
    outPorts = UnmodifiableSetView(_outPorts);

    graph.nodes.add(this);
  }

  void registerPorts(Set<InPort> inPorts, Set<OutPort> outPorts);

  @protected
  void sendTo<T>(OutPort<T> port, T value) {
    if (!_outPorts.contains(port)) {
      throw Exception(
          "A value was sent to a port not registered on the current node");
    }

    port._send(value);
  }
}
