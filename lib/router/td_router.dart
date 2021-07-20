//
//  td_router
//  app_flutter
//
//  Created by dingyang on2021/7/14 .
//  Copyright ©2021/7/14 app_flutter. All rights reserved.


import 'package:app_flutter/router/router_utils.dart';
import 'package:flutter/material.dart';

class TDRouter {
  /// 欢迎页面  倒计时页面
  static const String welcome_page = '/welcome_page';

  /// 主页面
  static const String main_page = "/main_page";

  /// 登录页面
  static const String login_page = "/login_page";

  /// 验证码登录页面
  static const String message_code_page = "/message_code_page";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
    //

      // case welcome_page:
      //   return FadeRouter(child: WelcomePage());
      //
      // case main_page:
      //   return FadeRouter(
      //       child: MainPage(MainPageParams(index: HomeBottomTabs.HOME.index)));
      //
      // case login_page:
      //   return Bottom2TopRouter(
      //       child: Login(settings.arguments as LoginPageParams));
      // case message_code_page:
      //   return Right2LeftRouter(
      //       child:
      //       MessageCodePage(settings.arguments as MessageCodePageParams));

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ));
    }
  }
}