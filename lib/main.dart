import 'dart:io';

import 'package:app_flutter/pages/app/app.dart';
import 'package:app_flutter/pages/app/bloc_wrapper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //滚动性能优化 1.22.0
  GestureBinding.instance!.resamplingEnabled = true;

  if (Platform.isAndroid) {
    // 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行
    // set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle =
    SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
  runApp(BlocWrapper(child: App()));
}
