//
//  welcome_service
//  app_flutter
//
//  Created by dingyang on2021/7/20 .
//  Copyright ©2021/7/20 app_flutter. All rights reserved.

import 'package:app_flutter/http/api.dart';
import 'package:app_flutter/http/http_manager.dart';
import 'package:app_flutter/http/result_data.dart';
import 'package:app_flutter/model/request/welcome_page_info_req.dart';
import 'package:app_flutter/model/response/welcome_page_info_resp.dart';
import 'package:flutter/material.dart';

import 'base_service.dart';
import 'dao/i_welcome_service_dao.dart';
import 'data_result.dart';

class WelcomeService extends BaseService implements IWelcomeServiceDao {
  WelcomeService(BuildContext buildContext) : super(buildContext);

  static WelcomeService? _instance;

  static WelcomeService instance(BuildContext context) {
    if (_instance == null) {
      _instance = new WelcomeService(context);
    }
    return _instance!;
  }

  @override
  getWelcomePageInfo() async {
    String url = Api.getWelcomePageUrl();
    WelcomePageInfoReq req = new WelcomePageInfoReq();
    // req.isMock = true;
    ResultData res = await HttpManager.getInstance(context)
        .netFetch(url, req, new WelcomePageInfoResp(), noTip: true);

    if (res.responseIsSuccess!) {
      WelcomePageInfoResp resp = res.responseData as WelcomePageInfoResp;
      return DataResult(resp, true);
    }
    return DataResult(null, false);
  }
}
