import 'package:computational_graph/computational_graph.dart';
import 'package:test/test.dart';

class StubNode extends Node {
  late final InPort<int, StubNode> intInput;
  late final OutPort<String, StubNode> stringOutput;

  StubNode(super.graph, {super.id});

  @override
  Iterable<InPort> createInPorts() {
    intInput = InPort(node: this, name: "intInput", onDataStreamAvailable: (_) {});
    return [intInput];
  }

  @override
  Iterable<OutPort> createOutPorts() {
    stringOutput = OutPort(node: this, name: "stringOutput");
    return [stringOutput];
  }
  
  @override
  String get typeName => "StubNode";
}

void main() {
  group('Port type tests', () => {
    test('.dataType should return the correct type', () {
      StubNode node = StubNode(Graph());
      expect(node.intInput.dataType, int);
      expect(node.stringOutput.dataType, String);
    })
  });
}