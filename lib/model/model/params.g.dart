// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Params _$ParamsFromJson(Map<String, dynamic> json) {
  return Params(
    linkUrl: json['linkUrl'] as String?,
    courseId: json['courseId'] as int?,
    index: json['index'] as int?,
    title: json['title'] as String?,
    leftIndex: json['leftIndex'] as int?,
    topIndex: json['topIndex'] as int?,
    categoryId: json['categoryId'] as int?,
    id: json['id'] as int?,
    postId: json['postId'] as int?,
  );
}

Map<String, dynamic> _$ParamsToJson(Params instance) => <String, dynamic>{
      'linkUrl': instance.linkUrl,
      'courseId': instance.courseId,
      'index': instance.index,
      'title': instance.title,
      'leftIndex': instance.leftIndex,
      'topIndex': instance.topIndex,
      'categoryId': instance.categoryId,
      'id': instance.id,
      'postId': instance.postId,
    };
