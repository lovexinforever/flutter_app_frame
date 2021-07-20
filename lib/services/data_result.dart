//
//  data_result
//  app_flutter
//
//  Created by dingyang on2021/7/14 .
//  Copyright ©2021/7/14 app_flutter. All rights reserved.

class DataResult {
  var data;
  bool result;
  Future? next;

  DataResult(this.data, this.result, {this.next});
}
