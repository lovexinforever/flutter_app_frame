// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'welcome_page_info_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WelcomePageInfoData _$WelcomePageInfoDataFromJson(Map<String, dynamic> json) {
  return WelcomePageInfoData(
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
    params: json['params'] as String?,
  );
}

Map<String, dynamic> _$WelcomePageInfoDataToJson(
        WelcomePageInfoData instance) =>
    <String, dynamic>{
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
      'params': instance.params,
    };
