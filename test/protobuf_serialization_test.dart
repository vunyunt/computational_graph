import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:computational_graph/computational_graph.dart';
import 'package:computational_graph/src/serialization/protobuf/models/graph.pbserver.dart';
import 'package:test/test.dart';

import 'fixtures/simple_addition_graph.dart';
import 'fixtures/simple_attribute_node.dart';

class GraphWithAttributes extends Graph {
  String? attribute1;
  int? attribute2;

  GraphWithAttributes({this.attribute1, this.attribute2});

  GraphWithAttributes.fromAttributeMap(Map<String, Uint8List>? attributeMap) {
    if (attributeMap == null) return;

    Uint8List? attribute1Bytes = attributeMap["attribute1"];
    Uint8List? attribute2Bytes = attributeMap["attribute2"];

    if (attribute1Bytes != null) {
      attribute1 = Utf8Decoder().convert(attribute1Bytes);
    }
    if (attribute2Bytes != null) {
      attribute2 = ByteData.view(attribute2Bytes.buffer).getUint64(0);
    }
  }

  @override
  Map<String, Uint8List> getAttributes() {
    return {
      if (attribute1 != null) "attribute1": Utf8Encoder().convert(attribute1!),
      if (attribute2 != null)
        "attribute2":
            (ByteData(8)..setInt64(0, attribute2!)).buffer.asUint8List()
    };
  }
}

void main() {
  group("Protobuf serialization tests", () {
    test('Serialization test', () async {
      SimpleAdditionGraph graph = SimpleAdditionGraph();
      ProtobufSerializer serializer = ProtobufSerializer();
      GraphProto serialized = serializer.serializeGraph(graph);

      expect(serialized.nodes.length, graph.nodes.entries.length);

      bool allNodesPresent = true;
      bool allEdgesPresent = true;

      for (final node in graph.nodes.entries) {
        allNodesPresent &=
            serialized.nodes.any((element) => element.id == node.value.id);

        for (final inPort in node.value.inPorts.values) {
          if (inPort.connected) {
            allEdgesPresent &= serialized.edges.any((element) =>
                element.toNodeId == node.value.id &&
                element.toPortName == inPort.name &&
                element.fromNodeId == inPort.edge!.from.node.id &&
                element.fromPortName == inPort.edge!.from.name);
          }
        }
      }

      expect(allNodesPresent, true);
      expect(allEdgesPresent, true);
    });

    test("Deserialization test", () async {
      SimpleAdditionGraph graph = SimpleAdditionGraph();
      ProtobufSerializer serializer = ProtobufSerializer();
      GraphProto serialized = serializer.serializeGraph(graph);
      SimpleAdditionGraph.registerFactoriesTo(serializer.registry);

      SimpleAdditionGraph deserialized = serializer.deserializeGraph(
          serialized, (_) => SimpleAdditionGraph.empty());

      Completer<int> execution = Completer();
      deserialized.output.onValueReceived = (p0) => execution.complete(p0);

      deserialized.input1.emit(5);
      deserialized.input2.emit(10);
      deserialized.input1.closeOutput();
      deserialized.input2.closeOutput();

      int result = await execution.future;
      expect(result, 15,
          reason:
              "Deserialized graph should compute the same as the original graph");
    });

    test("Attribute serialization test", () async {
      GraphWithAttributes graph =
          GraphWithAttributes(attribute1: "testString", attribute2: 10);
      ProtobufSerializer serializer = ProtobufSerializer();
      SimpleAttributeNode.registerFactoryTo(serializer.registry);
      SimpleAttributeNode node = SimpleAttributeNode(graph);
      node.someAttribute = "someValue";
      GraphProto serialized = serializer.serializeGraph(graph);

      GraphWithAttributes deserialized = serializer.deserializeGraph(serialized,
          (attributes) => GraphWithAttributes.fromAttributeMap(attributes));
      SimpleAttributeNode deserializedNode =
          deserialized.nodes.entries.first.value as SimpleAttributeNode;

      expect(deserialized.attribute1, graph.attribute1,
          reason:
              "Graph attribute should be serialized/deserialized correctly");
      expect(deserialized.attribute2, graph.attribute2,
          reason:
              "Graph attribute should be serialized/deserialized correctly");
      expect(deserializedNode.someAttribute, "someValue");
    });
  });
}
