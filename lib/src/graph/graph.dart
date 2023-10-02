import 'dart:async';
import 'dart:collection';
import 'dart:typed_data';

import './has_id.dart';
import 'package:meta/meta.dart';

part 'port.dart';
part 'node.dart';
part 'edge.dart';

class Graph {
  late final Map<String, Node> nodes;

  Graph({Map<String, Node>? nodes}) {
    this.nodes = nodes ?? {};
  }
}
