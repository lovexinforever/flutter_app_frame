//
//  adv_data
//  app_flutter
//
//  Created by dingyang on2021/7/20 .
//  Copyright ©2021/7/20 app_flutter. All rights reserved.

import 'package:app_flutter/database/data_tables.dart';
import 'package:app_flutter/database/model/base/db_base_bean.dart';
import 'package:json_annotation/json_annotation.dart';
part 'welcome_page_info_data.g.dart';

@JsonSerializable(explicitToJson: true)
class WelcomePageInfoData extends DbBaseBean {
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

  String? params;

  WelcomePageInfoData(
      {this.linkCode,
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
      this.params});

  factory WelcomePageInfoData.fromJson(Map<String, dynamic> json) =>
      _$WelcomePageInfoDataFromJson(json);

  Map<String, dynamic> toJson() => _$WelcomePageInfoDataToJson(this);


  @override
  fromMap(Map<String, dynamic> map) {
    return WelcomePageInfoData.fromJson(map);
  }

  @override
  String getTableName() {
    return "${DataTables.WELCOME_PAGE_INFO_CONFIG}";
  }

  @override
  Map<String, dynamic> toMap() {
    return toJson();
  }
}
