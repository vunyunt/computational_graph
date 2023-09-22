import 'package:uuid/v4.dart';

abstract class HasId {
  late final String id;

  HasId(String? id) {
    this.id = id ?? UuidV4().generate();
  }
}