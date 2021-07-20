import 'dart:async';

import 'package:app_flutter/log/logger.dart';
import 'package:app_flutter/services/data_result.dart';
import 'package:app_flutter/services/welcome_service.dart';
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

      DataResult result =
          await WelcomeService.instance(event.props[0] as BuildContext)
              .getWelcomePageInfo();
    }
  }
}
