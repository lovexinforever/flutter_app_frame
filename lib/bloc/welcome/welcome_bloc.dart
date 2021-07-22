import 'dart:async';
import 'dart:convert';

import 'package:app_flutter/database/dao/welcome_config_dao.dart';
import 'package:app_flutter/database/db_helper.dart';
import 'package:app_flutter/database/model/welcome_page_info_data.dart';
import 'package:app_flutter/log/logger.dart';
import 'package:app_flutter/model/model/adv.dart';
import 'package:app_flutter/services/data_result.dart';
import 'package:app_flutter/services/welcome_service.dart';
import 'package:app_flutter/utils/utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'welcome_event.dart';

part 'welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(WelcomeInitial());

  @override
  Stream<WelcomeState> mapEventToState(
    WelcomeEvent event,
  ) async* {
    if (event is GetWelcomePageInfoEvent) {
      Logger.d("开始查询欢迎页面配置信息");

      yield* getWelcomePageInfo();
      DataResult result =
          await WelcomeService.instance(event.props[0] as BuildContext)
              .getWelcomePageInfo();

      if (result.result) {
        List<Adv>? data = result.data;

        if (Utils.isEmpty(data) || data!.length == 0) {
          return;
        }

        Adv adv = data[0];

        Map<String, dynamic> map = adv.toJson();

        map["params"] = json.encode(adv.params ?? {});

        await WelcomeConfigDao.insertWelcomeConfigInfo(
            WelcomePageInfoData.fromJson(map));
      }

      yield* getWelcomePageInfo();
    }
  }

  Stream<WelcomeState> getWelcomePageInfo() async* {
    WelcomePageInfoData? data = await WelcomeConfigDao.getWelcomeConfigData();

    if (Utils.isEmpty(data)) {
      Logger.w("未查到还原页面数据");

      yield WelcomeInfoNoDataState();
      return;
    }

    Map<String, dynamic> map = data!.toJson();

    map["params"] = json.decode(data.params ?? "{}");

    Adv adv = Adv.fromJson(map);

    Logger.d("查询到欢迎页面数据 adv = ${adv.toJson()}");

    yield WelcomeInfoDataState(adv);
  }
}
