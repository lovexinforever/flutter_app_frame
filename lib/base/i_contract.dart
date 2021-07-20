//
//  i_contract
//  app_flutter
//
//  Created by dingyang on2021/7/14 .
//  Copyright ©2021/7/14 app_flutter. All rights reserved.

import 'package:flutter/material.dart';

abstract class IView {
  /// 显示toast
  showToast(String message);

  /// 显示loading框
  showLoading();

  /// 隐藏loading 框
  hideLoading();

  /// 返回上一页
  goBack();
}

abstract class IPresenter {
  /// 初始化
  init(BuildContext context);

  /// 获取数据
  getData();
}
