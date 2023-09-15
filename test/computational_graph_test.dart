import 'dart:async';

import 'package:computational_graph/computational_graph.dart';
import 'package:test/test.dart';

/// A simple node that simply records the last received value
class SimpleOutputNode<T> extends Node {
  Function(T)? onValueReceived;

  late InPort<T> input;

  SimpleOutputNode(super.graph);

  void receiveValue(T value) {
    if (onValueReceived != null) {
      onValueReceived!(value);
    }
  }

  @override
  void registerPorts(Set<InPort> inPorts, Set<OutPort> outPorts) {
    input = InPort(this, receiveValue);

    inPorts.add(input);
  }
}

/// A simple node to accumulate all inputs
class AccumulateNode extends Node {
  int total = 0;

  late InPort<int> a;
  late InPort<int> b;

  late OutPort<int> output;

  AccumulateNode(super.graph);

  void add(int value) {
    total += value;
    sendTo(output, total);
  }

  @override
  void registerPorts(Set<InPort> inPorts, Set<OutPort> outPorts) {
    a = InPort(this, add);
    b = InPort(this, add);
    output = OutPort(this);

    inPorts.addAll([a, b]);
    outPorts.add(output);
  }
}

/// A simple input node that emits a set value
class SimpleInputNode extends Node {
  late OutPort<int> output;

  SimpleInputNode(super.graph);

  @override
  void registerPorts(Set<InPort> inPorts, Set<OutPort> outPorts) {
    output = OutPort(this);
    outPorts.add(output);
  }

  void emit(int value) {
    sendTo(output, value);
  }
}

class Nodes {
  SimpleInputNode input1;
  SimpleInputNode input2;
  AccumulateNode addition;
  SimpleOutputNode<int> output;

  Nodes(
      {required this.input1,
      required this.input2,
      required this.addition,
      required this.output});
}

void main() {
  group('Graph tests', () {
    setupNodes() {
      Graph graph = Graph();

      SimpleInputNode input1 = SimpleInputNode(graph);
      SimpleInputNode input2 = SimpleInputNode(graph);
      AccumulateNode addition = AccumulateNode(graph);
      SimpleOutputNode<int> output = SimpleOutputNode(graph);

      input1.output.connectTo(addition.a);
      input2.output.connectTo(addition.b);
      addition.output.connectTo(output.input);

      return Nodes(
          input1: input1, input2: input2, addition: addition, output: output);
    }

    test('Simple addition test', () async {
      Nodes nodes = setupNodes();

      nodes.input1.emit(5);
      nodes.input2.emit(10);

      Completer<int> execution = Completer();

      int receivedCount = 0;
      nodes.output.onValueReceived = (val) {
        if (++receivedCount == 2) {
          execution.complete(val);
        }
      };

      int result = await execution.future;
      expect(result, 15);
    });
  });
}
