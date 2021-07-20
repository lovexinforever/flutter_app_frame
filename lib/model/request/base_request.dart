//
//  base_request
//  app_flutter
//
//  Created by dingyang on2021/7/14 .
//  Copyright ©2021/7/14 app_flutter. All rights reserved.
/// request 基类
abstract class BaseRequest {
  bool isMock = false;

  toJson();
}
