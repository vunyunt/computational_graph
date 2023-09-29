//
//  Generated code. Do not modify.
//  source: graph.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class GraphProto extends $pb.GeneratedMessage {
  factory GraphProto({
    $core.int? serializerVersion,
    $core.Iterable<NodeProto>? nodes,
    $core.Iterable<EdgeProto>? edges,
  }) {
    final $result = create();
    if (serializerVersion != null) {
      $result.serializerVersion = serializerVersion;
    }
    if (nodes != null) {
      $result.nodes.addAll(nodes);
    }
    if (edges != null) {
      $result.edges.addAll(edges);
    }
    return $result;
  }
  GraphProto._() : super();
  factory GraphProto.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GraphProto.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GraphProto', createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'serializerVersion', $pb.PbFieldType.O3, protoName: 'serializerVersion')
    ..pc<NodeProto>(2, _omitFieldNames ? '' : 'nodes', $pb.PbFieldType.PM, subBuilder: NodeProto.create)
    ..pc<EdgeProto>(3, _omitFieldNames ? '' : 'edges', $pb.PbFieldType.PM, subBuilder: EdgeProto.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GraphProto clone() => GraphProto()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GraphProto copyWith(void Function(GraphProto) updates) => super.copyWith((message) => updates(message as GraphProto)) as GraphProto;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GraphProto create() => GraphProto._();
  GraphProto createEmptyInstance() => create();
  static $pb.PbList<GraphProto> createRepeated() => $pb.PbList<GraphProto>();
  @$core.pragma('dart2js:noInline')
  static GraphProto getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GraphProto>(create);
  static GraphProto? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get serializerVersion => $_getIZ(0);
  @$pb.TagNumber(1)
  set serializerVersion($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSerializerVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearSerializerVersion() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<NodeProto> get nodes => $_getList(1);

  @$pb.TagNumber(3)
  $core.List<EdgeProto> get edges => $_getList(2);
}

class AttributeEntry extends $pb.GeneratedMessage {
  factory AttributeEntry({
    $core.String? key,
    $core.List<$core.int>? value,
  }) {
    final $result = create();
    if (key != null) {
      $result.key = key;
    }
    if (value != null) {
      $result.value = value;
    }
    return $result;
  }
  AttributeEntry._() : super();
  factory AttributeEntry.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AttributeEntry.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AttributeEntry', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'key')
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'value', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AttributeEntry clone() => AttributeEntry()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AttributeEntry copyWith(void Function(AttributeEntry) updates) => super.copyWith((message) => updates(message as AttributeEntry)) as AttributeEntry;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AttributeEntry create() => AttributeEntry._();
  AttributeEntry createEmptyInstance() => create();
  static $pb.PbList<AttributeEntry> createRepeated() => $pb.PbList<AttributeEntry>();
  @$core.pragma('dart2js:noInline')
  static AttributeEntry getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AttributeEntry>(create);
  static AttributeEntry? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get key => $_getSZ(0);
  @$pb.TagNumber(1)
  set key($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get value => $_getN(1);
  @$pb.TagNumber(2)
  set value($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => clearField(2);
}

class NodeProto extends $pb.GeneratedMessage {
  factory NodeProto({
    $core.String? type,
    $core.String? id,
    $core.Iterable<AttributeEntry>? attributes,
  }) {
    final $result = create();
    if (type != null) {
      $result.type = type;
    }
    if (id != null) {
      $result.id = id;
    }
    if (attributes != null) {
      $result.attributes.addAll(attributes);
    }
    return $result;
  }
  NodeProto._() : super();
  factory NodeProto.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeProto.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NodeProto', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'type')
    ..aOS(2, _omitFieldNames ? '' : 'id')
    ..pc<AttributeEntry>(3, _omitFieldNames ? '' : 'attributes', $pb.PbFieldType.PM, subBuilder: AttributeEntry.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeProto clone() => NodeProto()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeProto copyWith(void Function(NodeProto) updates) => super.copyWith((message) => updates(message as NodeProto)) as NodeProto;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NodeProto create() => NodeProto._();
  NodeProto createEmptyInstance() => create();
  static $pb.PbList<NodeProto> createRepeated() => $pb.PbList<NodeProto>();
  @$core.pragma('dart2js:noInline')
  static NodeProto getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NodeProto>(create);
  static NodeProto? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get type => $_getSZ(0);
  @$pb.TagNumber(1)
  set type($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get id => $_getSZ(1);
  @$pb.TagNumber(2)
  set id($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasId() => $_has(1);
  @$pb.TagNumber(2)
  void clearId() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<AttributeEntry> get attributes => $_getList(2);
}

class EdgeProto extends $pb.GeneratedMessage {
  factory EdgeProto({
    $core.String? fromNodeId,
    $core.String? fromPortName,
    $core.String? toNodeId,
    $core.String? toPortName,
  }) {
    final $result = create();
    if (fromNodeId != null) {
      $result.fromNodeId = fromNodeId;
    }
    if (fromPortName != null) {
      $result.fromPortName = fromPortName;
    }
    if (toNodeId != null) {
      $result.toNodeId = toNodeId;
    }
    if (toPortName != null) {
      $result.toPortName = toPortName;
    }
    return $result;
  }
  EdgeProto._() : super();
  factory EdgeProto.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EdgeProto.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EdgeProto', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fromNodeId', protoName: 'fromNodeId')
    ..aOS(2, _omitFieldNames ? '' : 'fromPortName', protoName: 'fromPortName')
    ..aOS(3, _omitFieldNames ? '' : 'toNodeId', protoName: 'toNodeId')
    ..aOS(4, _omitFieldNames ? '' : 'toPortName', protoName: 'toPortName')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EdgeProto clone() => EdgeProto()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EdgeProto copyWith(void Function(EdgeProto) updates) => super.copyWith((message) => updates(message as EdgeProto)) as EdgeProto;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EdgeProto create() => EdgeProto._();
  EdgeProto createEmptyInstance() => create();
  static $pb.PbList<EdgeProto> createRepeated() => $pb.PbList<EdgeProto>();
  @$core.pragma('dart2js:noInline')
  static EdgeProto getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EdgeProto>(create);
  static EdgeProto? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fromNodeId => $_getSZ(0);
  @$pb.TagNumber(1)
  set fromNodeId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFromNodeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFromNodeId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get fromPortName => $_getSZ(1);
  @$pb.TagNumber(2)
  set fromPortName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFromPortName() => $_has(1);
  @$pb.TagNumber(2)
  void clearFromPortName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get toNodeId => $_getSZ(2);
  @$pb.TagNumber(3)
  set toNodeId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasToNodeId() => $_has(2);
  @$pb.TagNumber(3)
  void clearToNodeId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get toPortName => $_getSZ(3);
  @$pb.TagNumber(4)
  set toPortName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasToPortName() => $_has(3);
  @$pb.TagNumber(4)
  void clearToPortName() => clearField(4);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
