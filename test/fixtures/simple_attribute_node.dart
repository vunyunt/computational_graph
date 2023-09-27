import 'dart:convert';
import 'dart:typed_data';

import 'package:computational_graph/computational_graph.dart';
import 'package:computational_graph/src/serialization/node_factory_registry.dart';

class SimpleAttributeNode extends Node {
  String someAttribute = "";

  SimpleAttributeNode(super.graph,
      {super.id, Map<String, Uint8List>? attributes}) {
    if (attributes != null && attributes.containsKey("someAttribute")) {
      someAttribute = Utf8Decoder().convert(attributes["someAttribute"]!);
    }
  }

  @override
  void createPorts(
      Map<String, InPort> inPorts, Map<String, OutPort> outPorts) {}

  @override
  String get typeName => "SimpleAttributeNode";

  static void registerFactoryTo(NodeFactoryRegistry registry) {
    registry.registerFactoryFor(
        "SimpleAttributeNode",
        (graph, {attributes, id}) =>
            SimpleAttributeNode(graph, id: id, attributes: attributes));
  }

  @override
  getAttributes() {
    return {"someAttribute": Utf8Encoder().convert(someAttribute)};
  }
}
