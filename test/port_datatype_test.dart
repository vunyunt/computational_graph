import 'dart:math';

import 'package:computational_graph/computational_graph.dart';
import 'package:test/test.dart';

class ExampleDataSuperclass {}

class ExampleDataClass extends ExampleDataSuperclass {}

class ExampleDataSubclass extends ExampleDataClass {}

class FromNode extends Node {
  late final OutPort<ExampleDataSuperclass, FromNode> superclassOutput;
  late final OutPort<ExampleDataClass, FromNode> dataClassOutput;
  late final OutPort<ExampleDataSubclass, FromNode> subclassOutput;

  FromNode(super.graph, {super.id});

  @override
  Iterable<InPort<dynamic, Node>> createInPorts() => [];

  @override
  Iterable<OutPort<dynamic, Node>> createOutPorts() {
    superclassOutput = OutPort(
        node: this,
        name: "superclassOutput",
        exampleValue: ExampleDataSuperclass());
    dataClassOutput = OutPort(
        node: this, name: "dataClassOutput", exampleValue: ExampleDataClass());
    subclassOutput = OutPort(
        node: this,
        name: "subclassOutput",
        exampleValue: ExampleDataSubclass());

    return [superclassOutput, dataClassOutput, subclassOutput];
  }

  @override
  String get typeName => "FromNode";
}

class ToNode extends Node {
  late final InPort<ExampleDataClass, ToNode> input;

  ToNode(super.graph);

  @override
  Iterable<InPort<dynamic, Node>> createInPorts() {
    input = InPort(node: this, name: "input", onDataStreamAvailable: (_) {});

    return [input];
  }

  @override
  Iterable<OutPort<dynamic, Node>> createOutPorts() => [];

  @override
  String get typeName => "ToNode";
}

void main() {
  group('Port datatype test', () {
    test('Edge.connect datatype compatibility test', () {
      Graph g = Graph();
      FromNode fromNode = FromNode(g);
      ToNode toNode = ToNode(g);

      expect(
          () => Edge<dynamic, dynamic>.connect(
              fromNode.superclassOutput as dynamic,
              // ignore: unnecessary_cast
              toNode.input as InPort<dynamic, Node>),
          throwsA(TypeMatcher<TypeError>()),
          reason: "InPort should only accept subclasses as data");
      expect(() => Edge.connect(fromNode.dataClassOutput, toNode.input),
          returnsNormally,
          reason: "InPort should accept matching data classes");
      expect(() => Edge.connect(fromNode.subclassOutput, toNode.input),
          returnsNormally,
          reason: "InPort should accept data subclasses");
    });
  });
}
