import 'dart:math';

import 'package:computational_graph/computational_graph.dart';
import 'package:test/test.dart';

class StubNode extends Node {
  late final InPort<int, StubNode> intInput;
  late final InPort<int, StubNode> intInput2;
  late final OutPort<String, StubNode> stringOutput;
  late final OutPort<int, StubNode> intOutput;
  late final OutPort<int, StubNode> intOuput2;

  StubNode(super.graph, {super.id});

  @override
  Iterable<InPort> createInPorts() {
    intInput =
        InPort(node: this, name: "intInput", onDataStreamAvailable: (_) {});
    intInput2 =
        InPort(node: this, name: "intInput2", onDataStreamAvailable: (_) {});
    return [intInput, intInput2];
  }

  @override
  Iterable<OutPort> createOutPorts() {
    stringOutput = OutPort(node: this, name: "stringOutput");
    intOutput = OutPort(node: this, name: "intOutput");
    intOuput2 = OutPort(node: this, name: "intOuput2");
    return [stringOutput, intOutput, intOuput2];
  }

  @override
  String get typeName => "StubNode";
}

void main() {
  group('Port type tests', () {
    test('.dataType should return the correct type', () {
      StubNode node = StubNode(Graph());
      expect(node.intInput.dataType, int);
      expect(node.stringOutput.dataType, String);
    });

    test('.canConnectTo should check compatibility correctly', () {
      StubNode node = StubNode(Graph());
      expect(node.intInput.canConnectTo(node.intOutput), true,
          reason:
              "OutPort should be compatible with InPort with compatible types");
      expect(node.intOutput.canConnectTo(node.intInput), true,
          reason:
              "InPort should be compatible with OutPort with compatible types");
      expect(node.intOuput2.canConnectTo(node.intOutput), false,
          reason: "OutPort shouold not be compatible with another OutPort");
      expect(node.intInput2.canConnectTo(node.intInput), false,
          reason: "InPort should not be compatible with another InPort");
      expect(node.intInput.canConnectTo(node.stringOutput), false,
          reason:
              'InPort should not be compatible with OutPort of mismatching type');
      expect(node.stringOutput.canConnectTo(node.intInput), false,
          reason:
              'OutPort should not be compatible with InPort of mismatching type');
    });
  });
}
