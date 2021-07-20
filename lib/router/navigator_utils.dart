//
//  navigator_utils
//  app_flutter
//
//  Created by dingyang on2021/7/14 .
//  Copyright ©2021/7/14 app_flutter. All rights reserved.

import 'package:app_flutter/log/logger.dart';
import 'package:app_flutter/utils/utils.dart';
import 'package:flutter/material.dart';

class NavigatorUtils {
  /// 返回
  static void goBack(BuildContext context) {
    // FocusScope.of(context).requestFocus(new FocusNode());
    Navigator.pop(context);
  }

  /// 带参数返回
  static void goBackWithParams(BuildContext context, result) {
    // FocusScope.of(context).requestFocus(new FocusNode());
    Navigator.pop(context, result);
  }

  static push(BuildContext context, String routerName,
      {Object? arguments, Function? function}) async {
    var result =
        await Navigator.of(context).pushNamed(routerName, arguments: arguments);

    if (Utils.isEmpty(result) || Utils.isEmpty(function)) {
      return false;
    }
    Logger.i("router back result ==== $result");
    return await function!(result);
  }
}
