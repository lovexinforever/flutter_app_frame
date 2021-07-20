//
//  utils
//  app_flutter
//
//  Created by dingyang on2021/7/14 .
//  Copyright ©2021/7/14 app_flutter. All rights reserved.

import 'package:flutter/material.dart';

class Utils {

  ///内容是否为空
  static bool isEmpty(content) {
//    content = content.toString();
//    Logger.log("content : " + content);
    return content == '' || content == null || content == "null";
  }

  /// 内容不为空
  static bool isNotEmpty(content) {
    return !isEmpty(content);
  }

  /// 隐藏软键盘
  static void focus(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  /// 屏幕高度
  static getScreenHeight(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return size.height;
  }

  /// 屏幕宽度
  static getScreenWidth(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return size.width;
  }
}