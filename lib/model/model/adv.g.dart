// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adv.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Adv _$AdvFromJson(Map<String, dynamic> json) {
  return Adv(
    linkCode: json['linkCode'] as String?,
    updateUser: json['updateUser'] as int?,
    updateTime: json['updateTime'] as String?,
    sort: json['sort'] as int?,
    type: json['type'] as String?,
    linkName: json['linkName'] as String?,
    pageImg: json['pageImg'] as String?,
    duration: json['duration'] as int?,
    createTime: json['createTime'] as String?,
    linkUrl: json['linkUrl'] as String?,
    createUser: json['createUser'] as int?,
    linkType: json['linkType'] as String?,
    endTime: json['endTime'] as String?,
    id: json['id'] as int?,
    courseId: json['courseId'] as int?,
    params: json['params'] == null
        ? null
        : Params.fromJson(json['params'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AdvToJson(Adv instance) => <String, dynamic>{
      'linkCode': instance.linkCode,
      'updateUser': instance.updateUser,
      'updateTime': instance.updateTime,
      'sort': instance.sort,
      'type': instance.type,
      'linkName': instance.linkName,
      'pageImg': instance.pageImg,
      'duration': instance.duration,
      'createTime': instance.createTime,
      'linkUrl': instance.linkUrl,
      'createUser': instance.createUser,
      'linkType': instance.linkType,
      'endTime': instance.endTime,
      'id': instance.id,
      'courseId': instance.courseId,
      'params': instance.params?.toJson(),
    };
