import 'dart:async';

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
  });
}
