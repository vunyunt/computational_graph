import 'dart:typed_data';

mixin HasSerializableAttributes {
  /// Get attributes of this object. Returns an empty map by default. Objects needing
  /// attribute serialization should implement this. Serializers should call this
  /// to serialize attributes
  Map<String, Uint8List> getAttributes() {
    return {};
  }
}
