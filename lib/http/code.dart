//
//  code
//  app_flutter
//
//  Created by dingyang on2021/7/14 .
//  Copyright ©2021/7/14 app_flutter. All rights reserved.
import 'package:app_flutter/model/response/base_response.dart';
import 'package:oktoast/oktoast.dart';

/// 错误码
class Code {
  ///网络错误
  static const NETWORK_ERROR = -1;

  ///网络超时
  static const NETWORK_TIMEOUT = -2;

  ///网络返回数据格式化一次
  static const NETWORK_JSON_EXCEPTION = -3;

  ///链接拒绝
  static const NETWORK_CONNECT_REFUSED = -4;

  ///ok
  static const SUCCESS = 200;

  /// 没有权限
  static const NO_PERMISSION = 401;

  ///fail
  static const ERROR = 500;

  static errorHandleFunction(code, message, noTip,
      {BaseResponse? baseResponse}) {
    if (noTip) {
      return baseResponse;
    }
    // eventBus.fire(new HttpErrorEvent(code, message));
    showToast(message ?? "数据异常", position: ToastPosition.bottom);
    return baseResponse;
  }
}
