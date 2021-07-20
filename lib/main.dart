import 'package:app_flutter/pages/app/app.dart';
import 'package:app_flutter/pages/app/bloc_wrapper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //滚动性能优化 1.22.0
  GestureBinding.instance!.resamplingEnabled = true;
  runApp(BlocWrapper(child: App()));
}
