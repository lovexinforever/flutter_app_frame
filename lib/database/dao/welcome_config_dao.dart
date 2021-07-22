//
//  welcome_config_dao
//  app_flutter
//
//  Created by dingyang on2021/7/20 .
//  Copyright ©2021/7/20 app_flutter. All rights reserved.


import 'package:app_flutter/database/data_tables.dart';
import 'package:app_flutter/database/db_helper.dart';
import 'package:app_flutter/database/model/welcome_page_info_data.dart';
import 'package:app_flutter/log/logger.dart';
import 'package:app_flutter/utils/utils.dart';
import 'package:sqflite/sqflite.dart';

class WelcomeConfigDao {

  /// 创建版本V1的欢迎页面配置
  static void createWelcomeConfigV1(Batch batch) {
    Logger.i("开始创建welcome config 表");
    batch.execute('DROP TABLE IF EXISTS ${DataTables.WELCOME_PAGE_INFO_CONFIG}');
    batch.execute('''CREATE TABLE ${DataTables.WELCOME_PAGE_INFO_CONFIG} (
    linkCode TEXT,
    updateUser INTEGER,
    updateTime TEXT,
    sort INTEGER,
    type TEXT,
    linkName TEXT,
    pageImg TEXT,
    duration INTEGER,
    createTime TEXT,
    linkUrl TEXT,
    createUser INTEGER,
    linkType TEXT,
    endTime TEXT,
    id INTEGER,
    courseId INTEGER,
    params TEXT
    )''');
  }

  static insertWelcomeConfigInfo(WelcomePageInfoData welcomePageInfoData) async {
    /// 先删除数据
    await DBHelper.getInstance()!.deleteItem(welcomePageInfoData);

    await DBHelper.getInstance()!.insertItem(welcomePageInfoData);
  }

  static Future<WelcomePageInfoData?> getWelcomeConfigData() async {
    List<WelcomePageInfoData?> list = await DBHelper.getInstance()!
        .queryItems<WelcomePageInfoData>(WelcomePageInfoData());

    if(Utils.isEmpty(list) || list.length == 0) {
      return null;
    }
    return list[0];
  }
}