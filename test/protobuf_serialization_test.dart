import 'dart:async';

import 'package:computational_graph/src/serialization/protobuf/models/graph.pbserver.dart';
import 'package:computational_graph/src/serialization/protobuf/protobuf_serializer.dart';
import 'package:test/test.dart';

import 'fixtures/simple_addition_graph.dart';

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

      SimpleAdditionGraph deserialized = SimpleAdditionGraph.empty();
      serializer.deserializeGraph(serialized, deserialized);

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
  });
}
