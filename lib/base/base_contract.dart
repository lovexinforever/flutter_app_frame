//
//  base_contract
//  app_flutter
//
//  Created by dingyang on2021/7/14 .
//  Copyright ©2021/7/14 app_flutter. All rights reserved.

import 'i_contract.dart';

abstract class IBaseView extends IView {
  //数据加载完成
  loadEnd();
}

abstract class IBasePresenter extends IPresenter {}
