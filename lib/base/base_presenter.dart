//
//  base_presenter
//  app_flutter
//
//  Created by dingyang on2021/7/14 .
//  Copyright ©2021/7/14 app_flutter. All rights reserved.

import 'package:flutter/material.dart';

import 'i_contract.dart';

abstract class BasePresenter<T extends IView> extends IPresenter {
  T view;

  BuildContext? mContext;

  BasePresenter(T v) : view = v;

  @override
  init(BuildContext context) {
    mContext = context;
  }
}
