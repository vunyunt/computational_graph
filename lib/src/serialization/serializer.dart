import 'package:computational_graph/src/graph/graph.dart';

abstract class Serializer<OutType> {
  OutType serializeGraph(Graph graph);
  OutType serializeNode(Node node);
  OutType serializeEdge(Edge edge);
}