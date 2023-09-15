import 'dart:async';
import 'dart:collection';

import 'package:meta/meta.dart';

part 'port.dart';
part 'node.dart';
part 'edge.dart';

class Graph {
  Node? root;
  final Set<Node> nodes = {};
}