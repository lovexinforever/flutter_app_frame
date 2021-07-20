//
//  api
//  app_flutter
//
//  Created by dingyang on2021/7/14 .
//  Copyright ©2021/7/14 app_flutter. All rights reserved.
import 'package:app_flutter/config/constant.dart';
import 'package:app_flutter/config/env_config.dart';

//// 所有请求接口的url地址
class Api {
  static String ServerUrl = Env.envConfig.host!;

  ///欢迎页面的 url
  static String getWelcomePageUrl() {
    return "$ServerUrl/page/getList?type=${PageConfig.WELCOME_PAGE}";
  }
}
