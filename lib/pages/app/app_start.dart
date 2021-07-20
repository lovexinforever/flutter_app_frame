//
//  app_start
//  app_flutter
//
//  Created by dingyang on2021/7/14 .
//  Copyright ©2021/7/14 app_flutter. All rights reserved.

import 'package:app_flutter/database/db_helper.dart';

class AppStart {
  initApp() async {
    /// 创建数据库
    await DBHelper.getInstance()!.getDatabase();
  }
}
