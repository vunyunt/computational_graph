import 'package:computational_graph/src/graph/graph.dart';

abstract class Serializer<SerializedType> {
  SerializedType serializeGraph(Graph graph);

  /// Deserialize a graph. If [graph] is passed in, the serializer should add
  /// nodes to the given graph. Otherwise a new one should be created;
  Graph deserializeGraph(SerializedType serializedGraph, Graph? graph);
}
