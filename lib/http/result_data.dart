//
//  result_data
//  app_flutter
//
//  Created by dingyang on2021/7/14 .
//  Copyright ©2021/7/14 app_flutter. All rights reserved.

import 'package:app_flutter/model/response/base_response.dart';

class ResultData {
  BaseResponse? responseData;
  bool? responseIsSuccess;
  int? responseCode;
  var headers;

  ResultData(this.responseData, this.responseIsSuccess, this.responseCode,
      {this.headers});
}
