import 'dart:async';
import 'dart:collection';

import 'package:computational_graph/src/has_serializable_attributes.dart';

import './has_id.dart';
import 'package:meta/meta.dart';

part 'port.dart';
part 'node.dart';
part 'edge.dart';

class Graph<NodeType extends Node> with HasSerializableAttributes {
  late final Map<String, NodeType> nodes;

  final StreamController<Edge> _onEdgeConnectedController =
      StreamController.broadcast();
  final StreamController<Edge> _onEdgeDisconnectedController =
      StreamController.broadcast();

  Stream<Edge> get onEdgeConnected => _onEdgeConnectedController.stream;
  Stream<Edge> get onEdgeDisconnected => _onEdgeDisconnectedController.stream;

  Graph({Map<String, NodeType>? nodes}) {
    this.nodes = nodes ?? {};
  }
}
