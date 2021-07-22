//
//  welcome_page_contract
//  app_flutter
//
//  Created by dingyang on2021/7/20 .
//  Copyright ©2021/7/20 app_flutter. All rights reserved.
import 'package:app_flutter/base/base_contract.dart';
import 'package:app_flutter/bloc/welcome/welcome_bloc.dart';
import 'package:app_flutter/model/model/params.dart';

abstract class IWelcomePageView extends IBaseView {
  /// 构建欢迎页面
  void buildWelcomePage(String pageImg, String linkType, String linkUrl,
      String linkCode, Params? params);

  /// 欢迎页面空页面
  void buildWelcomePageEmpty();

  /// 构建协议弹框
  void buildAgreement();

  /// 构建倒计时的按钮
  void buildCountDownWidget(int count);

  /// 跳转到主页面
  void go2MainPage();
}

abstract class IWelcomePagePresenter extends IBasePresenter {
  /// 根据state 处理页面
  void handlePageState(WelcomeState welcomeState);

  /// 同意协议
  void agreement();

  /// 页面销毁
  void destroy();
}
