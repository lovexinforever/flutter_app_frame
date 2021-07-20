//
//  sp_utils
//  app_flutter
//
//  Created by dingyang on2021/7/14 .
//  Copyright ©2021/7/14 app_flutter. All rights reserved.

import 'package:app_flutter/log/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SPUtils {
  static SharedPreferences? _sp;

  // 如果_sp已存在，直接返回，为null时创建
  static Future<SharedPreferences> get sp async {
    if (_sp == null) {
      _sp = await SharedPreferences.getInstance();
    }
    return _sp!;
  }

  static Future<bool> save(String key, String value) async {
    Logger.i("save  key = $key , value = $value");
    return (await sp).setString(key, value);
  }

  static Future<bool> saveBool(String key, bool value) async {
    return (await sp).setBool(key, value);
  }

  static dynamic get(String key) async {
    return (await sp).get(key);
  }

  static Future<bool> saveInt(String key, int value) async {
    return (await sp).setInt(key, value);
  }

  static Future<int?> getInt(String key) async {
    return (await sp).getInt(key);
  }

  static Future<bool?> getBool(String key) async {
    return (await sp).getBool(key);
  }

  static Future<bool> remove(String key) async {
    return (await sp).remove(key);
  }
}

class SPKeys {}
