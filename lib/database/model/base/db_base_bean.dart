//
//  db_base_bean
//  app_flutter
//
//  Created by dingyang on2021/7/14 .
//  Copyright ©2021/7/14 app_flutter. All rights reserved.

// 基础bean，工具类操作依赖此bean
abstract class DbBaseBean {
  /// 构造函数
  DbBaseBean();

  /// 实体转换Map
  Map<String, dynamic> toMap();

  /// map转实体
  fromMap(Map<String, dynamic> map);

  /// 关联表名称
  String getTableName();
}
