//
//  params
//  app_flutter
//
//  Created by dingyang on2021/7/20 .
//  Copyright ©2021/7/20 app_flutter. All rights reserved.
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'params.g.dart';

@JsonSerializable(explicitToJson: true)
class Params {
  String? linkUrl;
  int? courseId;

  int? index; //索引

  String? title; //标题

  int? leftIndex; //会员精选左边的index

  int? topIndex; //会员精选上面的index

  // List<TabCategory> list;

  int? categoryId;

  int? id; //id

  int? postId;

  Params({
    this.linkUrl,
    this.courseId,
    this.index,
    this.title,
    this.leftIndex,
    this.topIndex,
    this.categoryId,
    this.id,
    this.postId,
  });

  factory Params.fromJson(Map<String, dynamic> json) => _$ParamsFromJson(json);

  Map<String, dynamic> toJson() => _$ParamsToJson(this);

  // 命名构造函数
  Params.empty();

  @override
  String toString() {
    return 'Params{linkUrl: $linkUrl, courseId: $courseId, index: $index, title: $title, leftIndex: $leftIndex, topIndex: $topIndex, categoryId: $categoryId, id: $id, postId: $postId}';
  }

  String toJsonString() => json.encode(toJson());
}
