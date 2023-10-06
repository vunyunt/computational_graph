import 'dart:async';
import 'dart:collection';
import 'dart:typed_data';

import './has_id.dart';
import 'package:meta/meta.dart';

part 'port.dart';
part 'node.dart';
part 'edge.dart';

class Graph<NodeType extends Node> {
  late final Map<String, NodeType> nodes;

  Graph({Map<String, NodeType>? nodes}) {
    this.nodes = nodes ?? {};
  }
}
