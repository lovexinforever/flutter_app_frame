//
//  base_response
//  app_flutter
//
//  Created by dingyang on2021/7/14 .
//  Copyright ©2021/7/14 app_flutter. All rights reserved.
/// response 基类
abstract class BaseResponse {
  var responseData;
  bool? responseIsSuccess;
  int? responseCode;

  BaseResponse buildMockResponse();

  BaseResponse jsonToResponse(json);
}
