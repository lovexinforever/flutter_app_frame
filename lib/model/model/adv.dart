//
//  adv
//  app_flutter
//
//  Created by dingyang on2021/7/20 .
//  Copyright ©2021/7/20 app_flutter. All rights reserved.


import 'package:app_flutter/model/model/params.dart';
import 'package:json_annotation/json_annotation.dart';

part 'adv.g.dart';

@JsonSerializable(explicitToJson: true)
class Adv {
  String? linkCode;

  int? updateUser;

  String? updateTime;

  int? sort;

  String? type;

  String? linkName;

  String? pageImg;

  int? duration;

  String? createTime;

  String? linkUrl;

  int? createUser;

  String? linkType;

  String? endTime;

  int? id;

  int? courseId;

  Params? params;
  Adv({
    this.linkCode,
    this.updateUser,
    this.updateTime,
    this.sort,
    this.type,
    this.linkName,
    this.pageImg,
    this.duration,
    this.createTime,
    this.linkUrl,
    this.createUser,
    this.linkType,
    this.endTime,
    this.id,
    this.courseId,
    this.params,
  });
  factory Adv.fromJson(Map<String, dynamic> json) =>
      _$AdvFromJson(json);

  Map<String, dynamic> toJson() => _$AdvToJson(this);

  // 命名构造函数
  Adv.empty();
}