import '../graph/graph.dart';

typedef NodeFactory = Node Function(Graph graph,
    {String? id, Map<String, dynamic>? attributes});

class NodeFactoryRegistry<SerializedType> {
  final Map<String, NodeFactory> _registry = {};

  void registerFactoryFor(String nodeType, NodeFactory factory) {
    _registry[nodeType] = factory;
  }

  NodeFactory? getFactoryFor(String nodeType) => _registry[nodeType];
}
