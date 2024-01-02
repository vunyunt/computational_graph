import 'dart:collection';
import 'dart:typed_data';

import 'package:computational_graph/src/graph/graph.dart';
import 'package:computational_graph/src/serialization/node_factory_registry.dart';
import 'package:computational_graph/src/serialization/protobuf/models/graph.pb.dart';
import 'package:computational_graph/src/serialization/serializer.dart';
import 'package:protobuf/protobuf.dart';

class UnknownNodeTypeException implements Exception {
  String message;

  UnknownNodeTypeException(this.message);
}

class UnknownNodeException implements Exception {}

class UnknownPortException implements Exception {}

class ProtobufSerializer implements Serializer<GeneratedMessage> {
  static const version = 1;

  final NodeFactoryRegistry<GeneratedMessage> registry = NodeFactoryRegistry();

  void registerFactoryFor(String nodeType, NodeFactory factory) {
    registry.registerFactoryFor(nodeType, factory);
  }

  EdgeProto serializeEdge(Edge edge) {
    return EdgeProto()
      ..fromNodeId = edge.from.node.id
      ..fromPortName = edge.from.name
      ..toNodeId = edge.to.node.id
      ..toPortName = edge.to.name;
  }

  Iterable<Edge> getAllEdges(Graph graph) {
    Set<Edge> edges = HashSet();

    for (final entry in graph.nodes.entries) {
      for (final portEntry in entry.value.inPorts.entries) {
        if (portEntry.value.edge != null) {
          edges.add(portEntry.value.edge!);
        }
      }
    }

    return edges;
  }

  @override
  GraphProto serializeGraph(Graph graph) {
    final edges = getAllEdges(graph);

    GraphProto serialized = GraphProto()
      ..serializerVersion = version
      ..nodes.addAll(
          graph.nodes.entries.map((entry) => serializeNode(entry.value)))
      ..edges.addAll(edges.map((edge) => serializeEdge(edge)))
      ..attributes
          .addAll(graph.getAttributes().entries.map((entry) => AttributeEntry()
            ..key = entry.key
            ..value = entry.value));

    return serialized;
  }

  NodeProto serializeNode(Node node) {
    return NodeProto()
      ..type = node.typeName
      ..id = node.id
      ..attributes.addAll(node
          .getAttributes()
          .entries
          .map((e) => AttributeEntry(key: e.key, value: e.value)));
  }

  @override
  GraphType deserializeGraph<GraphType extends Graph>(
      GeneratedMessage serializedGraph, GraphFactory<GraphType> graphFactory) {
    GraphProto graphProto = serializedGraph as GraphProto;

    Map<String, Uint8List> graphAttributes = {};
    for (final entry in graphProto.attributes) {
      graphAttributes[entry.key] = Uint8List.fromList(entry.value);
    }

    GraphType graph = graphFactory(graphAttributes);

    for (final nodeProto in graphProto.nodes) {
      deserializeNode(graph, nodeProto);
    }

    for (final edgeProto in graphProto.edges) {
      deserializeEdge(graph, edgeProto);
    }

    return graph;
  }

  Node deserializeNode(Graph graph, NodeProto serializedNode) {
    final factory = registry.getFactoryFor(serializedNode.type);
    if (factory == null) {
      throw UnknownNodeTypeException(
          "Node factory for type ${serializedNode.type} not found");
    }

    Map<String, Uint8List> attributes = {};
    for (final entry in serializedNode.attributes) {
      attributes[entry.key] = Uint8List.fromList(entry.value);
    }

    return factory(graph, id: serializedNode.id, attributes: attributes);
  }

  Edge deserializeEdge(Graph graph, EdgeProto serializedEdge) {
    Node? fromNode = graph.nodes[serializedEdge.fromNodeId];
    Node? toNode = graph.nodes[serializedEdge.toNodeId];

    if (fromNode == null || toNode == null) {
      throw UnknownNodeException();
    }

    final fromPort = fromNode.outPorts[serializedEdge.fromPortName];
    final toPort = toNode.inPorts[serializedEdge.toPortName];

    if (fromPort == null || toPort == null) {
      throw UnknownPortException();
    }

    return Edge.connect(fromPort, toPort);
  }
}
