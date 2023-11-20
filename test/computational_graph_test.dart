import 'dart:async';

import 'package:computational_graph/computational_graph.dart';
import 'package:test/test.dart';

import 'fixtures/simple_addition_graph.dart';

void main() {
  group('Graph tests', () {
    test('Simple addition test', () async {
      SimpleAdditionGraph graph = SimpleAdditionGraph();

      Completer<int> execution = Completer();
      graph.output.onValueReceived = (p0) => execution.complete(p0);

      graph.input1.emit(5);
      graph.input2.emit(10);
      graph.input1.closeOutput();
      graph.input2.closeOutput();

      int result = await execution.future;
      expect(result, 15);
    });

    test('Connection event test', () {
      Graph graph = Graph();

      SimpleInputNode input = SimpleInputNode(graph, id: 'input');
      SimpleOutputNode output = SimpleOutputNode(graph, id: 'output');

      final connectCallback = expectAsync1(
          (Edge edge) => expect(
              edge,
              (Edge edge) =>
                  edge.from.node.id == input.id &&
                  edge.to.node.id == output.id),
          reason: "Connect event should be sent");

      graph.onEdgeConnected.listen(connectCallback);

      input.output.connectTo(output.input);
    });

    test('Connection replacement disconnect event test,', () {
      Graph graph = Graph();

      SimpleInputNode input1 = SimpleInputNode(graph, id: 'input1');
      SimpleInputNode input2 = SimpleInputNode(graph, id: 'input2');
      SimpleOutputNode output = SimpleOutputNode(graph, id: 'output');

      input1.output.connectTo(output.input);

      final disconnectCallback = expectAsync1(
          (Edge edge) => expect(
              edge,
              (Edge e) =>
                  e.from.node.id == input1.id && e.to.node.id == output.id),
          reason: "Disconnect event of the old edge should be sent");

      graph.onEdgeDisconnected.listen(disconnectCallback);

      input2.output.connectTo(output.input);
    });
  });
}
