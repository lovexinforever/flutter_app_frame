//
//  welcome_page_info_resp
//  app_flutter
//
//  Created by dingyang on2021/7/20 .
//  Copyright ©2021/7/20 app_flutter. All rights reserved.
import 'dart:convert';

import 'package:app_flutter/model/model/adv.dart';
import 'package:app_flutter/utils/utils.dart';
import 'package:json_annotation/json_annotation.dart';

import 'base_response.dart';

part 'welcome_page_info_resp.g.dart';

@JsonSerializable(explicitToJson: true)
class WelcomePageInfoResp extends BaseResponse {
  List<Adv>? data;

  WelcomePageInfoResp({
    this.data,
  });

  @override
  BaseResponse buildMockResponse() {
    // TODO: implement buildMockResponse
    throw UnimplementedError();
  }

  @override
  BaseResponse jsonToResponse(json) {
    var data = json['data'];

    data.forEach((item) => {
          // Logger.log(message)
          item['params'] = Utils.isNotEmpty(item['params'])
              ? jsonDecode(item['params'])
              : new Map<String, dynamic>(),
        });

    Map<String, dynamic> map = {"data": data};
    return WelcomePageInfoResp.fromJson(map);
  }

  factory WelcomePageInfoResp.fromJson(Map<String, dynamic> json) =>
      _$WelcomePageInfoRespFromJson(json);

  Map<String, dynamic> toJson() => _$WelcomePageInfoRespToJson(this);

  // 命名构造函数
  WelcomePageInfoResp.empty();
}
