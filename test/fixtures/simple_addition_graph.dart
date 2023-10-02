import 'package:computational_graph/computational_graph.dart';

/// A simple node that simply records the last received value
class SimpleOutputNode extends Node {
  static String name = "SimpleOutputNode";
  @override
  String get typeName => name;

  Function(int)? onValueReceived;

  late InPort<int> input;

  SimpleOutputNode(super.graph, {super.id});

  void receiveValue(int value) {
    if (onValueReceived != null) {
      onValueReceived!(value);
    }
  }

  @override
  Iterable<InPort> createInPorts() {
    input = InPort(
        node: this,
        name: "input",
        onDataStreamAvailable: (stream) => {
              stream.listen((value) {
                receiveValue(value);
              })
            });

    return [input];
  }

  @override
  Iterable<OutPort> createOutPorts() => [];
}

/// A simple node to accumulate all inputs.
/// The result is only sent when all inputs are closed.
class AccumulateNode extends Node {
  static String name = "AccumulateNode";
  @override
  String get typeName => name;

  int total = 0;

  late InPort<int> a;
  late InPort<int> b;

  late OutPort<int> output;

  AccumulateNode(super.graph, {super.id});

  onStreamClosed() {
    if ((!a.isOpen) && (!b.isOpen) && output.isOpen) {
      sendTo(output, total);
      close(output);
    }
  }

  @override
  Iterable<InPort> createInPorts() {
    a = InPort<int>(
        node: this,
        name: "a",
        onDataStreamAvailable: (stream) {
          stream.listen((val) {
            total += val;
          }, onDone: onStreamClosed);
        });
    b = InPort<int>(
        node: this,
        name: "b",
        onDataStreamAvailable: (stream) {
          stream.listen((val) {
            total += val;
          }, onDone: onStreamClosed);
        });

    return [a, b];
  }

  @override
  Iterable<OutPort> createOutPorts() {
    output = OutPort(node: this, name: "output");
    return [output];
  }
}

/// A simple input node that emits a set value
class SimpleInputNode extends Node {
  static String name = "SimpleInputNode";
  @override
  String get typeName => name;

  late OutPort<int> output;

  SimpleInputNode(super.graph, {super.id});

  @override
  Iterable<InPort> createInPorts() => [];
  @override
  Iterable<OutPort> createOutPorts() {
    output = OutPort(node: this, name: "output");
    return [output];
  }

  void emit(int value) {
    sendTo(output, value);
  }

  void closeOutput() {
    close(output);
  }
}

class SimpleAdditionGraph extends Graph {
  SimpleInputNode get input1 => nodes['input1']! as SimpleInputNode;
  SimpleInputNode get input2 => nodes['input2']! as SimpleInputNode;
  AccumulateNode get addition => nodes['addition'] as AccumulateNode;
  SimpleOutputNode get output => nodes['output'] as SimpleOutputNode;

  SimpleAdditionGraph() {
    nodes['input1'] = SimpleInputNode(this, id: 'input1');
    nodes['input2'] = SimpleInputNode(this, id: 'input2');
    nodes['addition'] = AccumulateNode(this, id: 'addition');
    nodes['output'] = SimpleOutputNode(this, id: 'output');

    input1.output.connectTo(addition.a);
    input2.output.connectTo(addition.b);
    addition.output.connectTo(output.input);
  }

  /// Create an empty instance of this graph. Intended for testing deserialization
  SimpleAdditionGraph.empty();

  static void registerFactoriesTo(NodeFactoryRegistry registry) {
    registry.registerFactoryFor(SimpleOutputNode.name,
        (graph, {attributes, id}) => SimpleOutputNode(graph, id: id));
    registry.registerFactoryFor(SimpleInputNode.name,
        (graph, {attributes, id}) => SimpleInputNode(graph, id: id));
    registry.registerFactoryFor(AccumulateNode.name,
        (graph, {attributes, id}) => AccumulateNode(graph, id: id));
  }
}
