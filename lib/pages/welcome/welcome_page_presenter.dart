//
//  welcome_page_presenter
//  app_flutter
//
//  Created by dingyang on2021/7/20 .
//  Copyright ©2021/7/20 app_flutter. All rights reserved.

import 'package:app_flutter/base/base_presenter.dart';
import 'package:app_flutter/bloc/welcome/welcome_bloc.dart';
import 'package:app_flutter/database/sp/sp_utils.dart';
import 'package:app_flutter/log/logger.dart';
import 'package:app_flutter/model/model/adv.dart';
import 'package:app_flutter/pages/welcome/welcome_page_contract.dart';
import 'package:app_flutter/utils/utils.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomePagePresenter extends BasePresenter<IWelcomePageView>
    implements IWelcomePagePresenter {
  WelcomePagePresenter(IWelcomePageView v) : super(v);

  /// 倒计时的时间
  static const int COUNT_DOWN_NUM = 3;

  /// 定时器
  TimerUtil? timerUtil;

  @override
  getData() async {
    Future.delayed(Duration(milliseconds: 500)).then((e) {
      BlocProvider.of<WelcomeBloc>(mContext!)
          .add(GetWelcomePageInfoEvent(mContext!));
    });

    bool? isAgree = await SPUtils.getBool(SPKeys.IS_AGREE);

    Logger.d("isAgree = $isAgree");

    if (Utils.isNotEmpty(isAgree) && isAgree!) {
      timerUtil =
          new TimerUtil(mInterval: 1000, mTotalTime: COUNT_DOWN_NUM * 1000);
      timerUtil?.setOnTimerTickCallback((int tick) {
        int time = tick ~/ 1000;
        view.buildCountDownWidget(time);
        if (time == 0) {
          view.go2MainPage();
        }
      });

      timerUtil?.startCountDown();
      return;
    }

    view.buildAgreement();
  }

  @override
  void agreement() {
    SPUtils.saveBool(SPKeys.IS_AGREE, true);
  }

  @override
  void destroy() {
    if (Utils.isEmpty(timerUtil)) {
      return;
    }
    if (timerUtil!.isActive()) {
      timerUtil!.cancel();
      timerUtil = null;
    }
  }

  @override
  void handlePageState(WelcomeState welcomeState) {
    if (welcomeState is WelcomeInfoDataState) {
      Adv adv = welcomeState.props[0] as Adv;

      view.buildWelcomePage(adv.pageImg ?? "", adv.linkType ?? "",
          adv.linkUrl ?? "", adv.linkCode ?? "", adv.params);
      return;
    }

    if (welcomeState is WelcomeInfoNoDataState) {
      view.buildWelcomePageEmpty();
    }
  }
}
