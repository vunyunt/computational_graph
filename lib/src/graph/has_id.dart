import 'package:uuid/v4.dart';

abstract class HasId {
  late String _id;

  String get id => _id;

  HasId(String? id) {
    _id = id ?? UuidV4().generate();
  }

  setId(String id) {
    _id = id;
  }
}
