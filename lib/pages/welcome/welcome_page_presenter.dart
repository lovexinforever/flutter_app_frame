//
//  welcome_page_presenter
//  app_flutter
//
//  Created by dingyang on2021/7/20 .
//  Copyright ©2021/7/20 app_flutter. All rights reserved.

import 'package:app_flutter/base/base_presenter.dart';
import 'package:app_flutter/bloc/welcome/welcome_bloc.dart';
import 'package:app_flutter/pages/welcome/welcome_page_contract.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomePagePresenter extends BasePresenter<IWelcomePageView>
    implements IWelcomePagePresenter {
  WelcomePagePresenter(IWelcomePageView v) : super(v);

  @override
  getData() {
    BlocProvider.of<WelcomeBloc>(mContext!)
        .add(GetWelcomePageInfoEvent(mContext!));
  }
}
