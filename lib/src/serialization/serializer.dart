import 'dart:typed_data';

import 'package:computational_graph/src/graph/graph.dart';

typedef GraphFactory<GraphType extends Graph> = GraphType Function(
    Map<String, Uint8List>? attributes);

abstract class Serializer<SerializedType> {
  SerializedType serializeGraph(Graph graph);

  /// Deserialize a graph. If [graph] is passed in, the serializer should add
  /// nodes to the given graph. Otherwise a new one should be created;
  GraphType deserializeGraph<GraphType extends Graph>(
      SerializedType serializedGraph, GraphFactory<GraphType> graph);
}
