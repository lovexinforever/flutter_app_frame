//
//  logger
//  app_flutter
//
//  Created by dingyang on2021/7/14 .
//  Copyright ©2021/7/14 app_flutter. All rights reserved.

import 'package:app_flutter/config/config.dart';
import 'package:logger/logger.dart' as Log;

var logger = Log.Logger(
  printer: Log.PrefixPrinter(Log.PrettyPrinter(colors: false, lineLength: 70)),
);

var loggerNoStack = Log.Logger(
  printer: Log.PrettyPrinter(methodCount: 0),
);

class Logger {
  // static SimpleLog logger = SimpleLog(appId: 13010, appKey: '91daac79d66e48b999a952fbf14b4885');
  //// 打印日志
  static void i(Object message, [Object? detail]) {
    if (Config.DEBUG) {
      logger.i(message, detail);
    }
  }

  static void w(Object message, [Object? detail]) {
    if (Config.DEBUG) {
      logger.w(message, detail);
    }
  }

  static void e(Object message, [Object? detail]) {
    if (Config.DEBUG) {
      logger.e(message, detail);
    }
  }

  static void d(Object message, [Object? detail]) {
    if (Config.DEBUG) {
      logger.d(message, detail);
    }
  }
}
