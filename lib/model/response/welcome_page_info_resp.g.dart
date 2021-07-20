// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'welcome_page_info_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WelcomePageInfoResp _$WelcomePageInfoRespFromJson(Map<String, dynamic> json) {
  return WelcomePageInfoResp(
    data: (json['data'] as List<dynamic>?)
        ?.map((e) => Adv.fromJson(e as Map<String, dynamic>))
        .toList(),
  )
    ..responseData = json['responseData']
    ..responseIsSuccess = json['responseIsSuccess'] as bool?
    ..responseCode = json['responseCode'] as int?;
}

Map<String, dynamic> _$WelcomePageInfoRespToJson(
        WelcomePageInfoResp instance) =>
    <String, dynamic>{
      'responseData': instance.responseData,
      'responseIsSuccess': instance.responseIsSuccess,
      'responseCode': instance.responseCode,
      'data': instance.data?.map((e) => e.toJson()).toList(),
    };
