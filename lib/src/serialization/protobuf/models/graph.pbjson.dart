//
//  Generated code. Do not modify.
//  source: graph.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use graphProtoDescriptor instead')
const GraphProto$json = {
  '1': 'GraphProto',
  '2': [
    {'1': 'serializerVersion', '3': 1, '4': 1, '5': 5, '10': 'serializerVersion'},
    {'1': 'nodes', '3': 2, '4': 3, '5': 11, '6': '.NodeProto', '10': 'nodes'},
    {'1': 'edges', '3': 3, '4': 3, '5': 11, '6': '.EdgeProto', '10': 'edges'},
  ],
};

/// Descriptor for `GraphProto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List graphProtoDescriptor = $convert.base64Decode(
    'CgpHcmFwaFByb3RvEiwKEXNlcmlhbGl6ZXJWZXJzaW9uGAEgASgFUhFzZXJpYWxpemVyVmVyc2'
    'lvbhIgCgVub2RlcxgCIAMoCzIKLk5vZGVQcm90b1IFbm9kZXMSIAoFZWRnZXMYAyADKAsyCi5F'
    'ZGdlUHJvdG9SBWVkZ2Vz');

@$core.Deprecated('Use attributeEntryDescriptor instead')
const AttributeEntry$json = {
  '1': 'AttributeEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 12, '10': 'value'},
  ],
};

/// Descriptor for `AttributeEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List attributeEntryDescriptor = $convert.base64Decode(
    'Cg5BdHRyaWJ1dGVFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoDFIFdmFsdW'
    'U=');

@$core.Deprecated('Use nodeProtoDescriptor instead')
const NodeProto$json = {
  '1': 'NodeProto',
  '2': [
    {'1': 'type', '3': 1, '4': 1, '5': 9, '10': 'type'},
    {'1': 'id', '3': 2, '4': 1, '5': 9, '10': 'id'},
    {'1': 'attributes', '3': 3, '4': 3, '5': 11, '6': '.AttributeEntry', '10': 'attributes'},
  ],
};

/// Descriptor for `NodeProto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nodeProtoDescriptor = $convert.base64Decode(
    'CglOb2RlUHJvdG8SEgoEdHlwZRgBIAEoCVIEdHlwZRIOCgJpZBgCIAEoCVICaWQSLwoKYXR0cm'
    'lidXRlcxgDIAMoCzIPLkF0dHJpYnV0ZUVudHJ5UgphdHRyaWJ1dGVz');

@$core.Deprecated('Use edgeProtoDescriptor instead')
const EdgeProto$json = {
  '1': 'EdgeProto',
  '2': [
    {'1': 'fromNodeId', '3': 1, '4': 1, '5': 9, '10': 'fromNodeId'},
    {'1': 'fromPortName', '3': 2, '4': 1, '5': 9, '10': 'fromPortName'},
    {'1': 'toNodeId', '3': 3, '4': 1, '5': 9, '10': 'toNodeId'},
    {'1': 'toPortName', '3': 4, '4': 1, '5': 9, '10': 'toPortName'},
  ],
};

/// Descriptor for `EdgeProto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List edgeProtoDescriptor = $convert.base64Decode(
    'CglFZGdlUHJvdG8SHgoKZnJvbU5vZGVJZBgBIAEoCVIKZnJvbU5vZGVJZBIiCgxmcm9tUG9ydE'
    '5hbWUYAiABKAlSDGZyb21Qb3J0TmFtZRIaCgh0b05vZGVJZBgDIAEoCVIIdG9Ob2RlSWQSHgoK'
    'dG9Qb3J0TmFtZRgEIAEoCVIKdG9Qb3J0TmFtZQ==');

