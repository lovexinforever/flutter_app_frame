//
//  welcome_page
//  app_flutter
//
//  Created by dingyang on2021/7/20 .
//  Copyright ©2021/7/20 app_flutter. All rights reserved.

import 'package:app_flutter/base/base_stateful_page.dart';
import 'package:app_flutter/pages/welcome/welcome_page_contract.dart';
import 'package:app_flutter/pages/welcome/welcome_page_presenter.dart';
import 'package:flutter/material.dart';

class WelcomePage extends BaseStatefulPage {
  @override
  State<StatefulWidget> createState() {
    return _WelcomePageState();
  }
}

class _WelcomePageState
    extends BaseStatefulPageState<WelcomePage, WelcomePagePresenter>
    implements IWelcomePageView {
  @override
  WelcomePagePresenter getPresenter() {
    return WelcomePagePresenter(this);
  }

  @override
  void netRequest() {
    // TODO: implement netRequest
  }

  @override
  Widget page(BuildContext context) {
    // TODO: implement page
    throw UnimplementedError();
  }

  @override
  void pageBeginMethod() {
    // TODO: implement pageBeginMethod
  }

  @override
  void pageDidMethod() {
    // TODO: implement pageDidMethod
  }

  @override
  void pageEndMethod() {
    // TODO: implement pageEndMethod
  }
}
