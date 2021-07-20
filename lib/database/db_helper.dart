//
//  db_helper
//  app_flutter
//
//  Created by dingyang on2021/7/14 .
//  Copyright ©2021/7/14 app_flutter. All rights reserved.

import 'package:app_flutter/log/logger.dart';
import 'package:app_flutter/utils/utils.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'model/base/db_base_bean.dart';

/// 数据库相关
class DBHelper {
  static Database? db;

  /// 数据库版本
  static int dbVersion = 1;

  /// 数据库名字
  static String dbName = "td";

  static DBHelper? getInstance() {
    if (null == dbHelper) dbHelper = DBHelper._();
    return dbHelper;
  }

  DBHelper._();

  static DBHelper? dbHelper;

  static Future<Database?> myHelper() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, '$dbName.db');
//根据数据库文件路径和数据库版本号创建数据库表
    db = await openDatabase(path, version: dbVersion, onConfigure: onConfigure,
        onCreate: (Database db, int version) async {
      var batch = db.batch();
      // GlobalConfigDao.createGlobalConfigV1(batch);
      // WelcomeConfigDao.createWelcomeConfigV1(batch);
      // StudyLastestDao.createStudyLastestV1(batch);
      // HomeBookCategoryDao.createHomeBookCategoryV1(batch);
      // LastNewBookDao.createLastNewBookV1(batch);
      // PageModuleDao.createPageModuleV1(batch);
      // NineIconDao.createNineIconV1(batch);
      // BannerDao.createBannersV1(batch);
      // AppConfigSwitchDao.createAppConfigSwitchV1(batch);
      // UserInfoDao.createUserInfoV1(batch);
      await batch.commit();
      // Timer(Duration(seconds: 1), () {
      //   GlobalConfigDao.insertGlobalConfig(
      //       GlobalConfigData(fontFamily: 0, themeColor: 1));
      // });
    }, onUpgrade: (db, oldVersion, newVersion) async {
      // var batch = db.batch();
      // switch (oldVersion) {
      //   case 1:
      //     WelcomeConfigDao.createWelcomeConfigV2(batch);
      //     break;
      // }
      // await batch.commit();
    });
    return db;
  }

  /// Let's use FOREIGN KEY constraints
  static Future onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  /// 打开数据库
  Future<Database?> getDatabase() async {
    if (Utils.isEmpty(db)) {
      db = await myHelper();
    }
    return db;
  }

  /// 关闭数据库
  closeDb() async {
    // 如果数据库存在，而且数据库没有关闭，先关闭数据库
    if (Utils.isNotEmpty(db) && db!.isOpen) {
      await db!.close();
      db = null;
    }
  }

  /// 删除数据库
  deleteDb() async {
    // 如果数据库路径不存在，赋值

    String databasesPath = await getDatabasesPath();

    await deleteDatabase(join(databasesPath, "$dbName.db"));
  }

  // 插入数据
  Future<void> insertItem<T extends DbBaseBean>(T t) async {
    // db = await getDatabase();
    if (Utils.isEmpty(db) || !db!.isOpen) {
      return;
    }
    Logger.d("start insert data ：${t.toMap()}");

    // 插入操作
    await db!.insert(t.getTableName(), t.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  /// 删除数据
  Future<void> deleteItem<T extends DbBaseBean>(T t,
      {List<String?>? key, List<String?>? value}) async {
    if (Utils.isEmpty(db) || !db!.isOpen) return;

    // 删除表
    if (Utils.isEmpty(key) || Utils.isEmpty(value)) {
      await db!.delete(t.getTableName());
    } else {
      // 删除数据
      String whereKey = "";
      for (int i = 0; i < key!.length; i++) {
        if (i == (key.length - 1)) {
          whereKey += "${key[i]} = ?";
        } else {
          whereKey += "${key[i]} = ? and ";
        }
      }
      await db!.delete(
        t.getTableName(),
        where: (whereKey),
        whereArgs: value,
      );
    }
  }

  /// 更新数据
  Future<void> updateItem<T extends DbBaseBean>(
      T t, List<String?>? key, List<String?>? value) async {
    if (Utils.isEmpty(db) || !db!.isOpen) return;

    Logger.d("start update data：${t.toMap()}");
    String whereKey = "";
    for (int i = 0; i < key!.length; i++) {
      if (i == (key.length - 1)) {
        whereKey += "${key[i]} = ?";
      } else {
        whereKey += "${key[i]} = ? and ";
      }
    }
    // 更新数据
    await db!.update(
      t.getTableName(),
      t.toMap(),
      where: whereKey,
      whereArgs: value,
    );
  }

  // 查询数据
  Future<List<T>> queryItems<T extends DbBaseBean>(T t,
      {List<String?>? key, List<String?>? value}) async {
    if (Utils.isEmpty(db) || !db!.isOpen) return [];
    List<Map<String, dynamic>> maps = [];

    // 列表数据
    if (Utils.isEmpty(key) || Utils.isEmpty(value)) {
      maps = await db!.query(t.getTableName());
    } else {
      String whereKey = "";
      for (int i = 0; i < key!.length; i++) {
        if (i == (key.length - 1)) {
          whereKey += "${key[i]} = ?";
        } else {
          whereKey += "${key[i]} = ? and ";
        }
      }
      maps = await db!.query(
        t.getTableName(),
        where: whereKey,
        whereArgs: value,
      );
    }

    // map转换为List集合
    return List.generate(maps.length, (i) {
      return t.fromMap(maps[i]);
    });
  }
}
