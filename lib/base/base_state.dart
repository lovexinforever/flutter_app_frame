//
//  base_state
//  app_flutter
//
//  Created by dingyang on2021/7/14 .
//  Copyright ©2021/7/14 app_flutter. All rights reserved.

import 'package:app_flutter/styles/td_styles.dart';
import 'package:app_flutter/utils/utils.dart';
import 'package:app_flutter/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';

import 'i_contract.dart';

abstract class BaseState<T extends StatefulWidget, E extends IPresenter>
    extends State<T> with AutomaticKeepAliveClientMixin {
  E? mPresenter;

  bool _loading = false;

  bool showDropDown = false; //显示下拉选框

  bool showPop = false; //显示一个全局的浮动层

  bool popFocus = false; // 浮动层是否强制显示

  //距离顶部的距离
  double top = 0;

  Widget dropDownWidget = Container();

  Widget popWidget = Container();

  @override
  void initState() {
    mPresenter = getPresenter();
    mPresenter!.init(context);
    super.initState();
    mPresenter!.getData();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        children: [
          GestureDetector(
            child: buildViews(context),
            onTap: () {
              Utils.focus(context);
            },
          ),
          _loading
              ? WillPopScope(
                  onWillPop: () async {
                    return false;
                  },
                  child: Positioned(child: new LoadingIndicator()))
              : Container(
                  width: 0.0,
                  height: 0.0,
                ),
          showDropDown
              ? Positioned(
                  child: GestureDetector(
                    child: Container(
                        width: Utils.getScreenWidth(context),
                        height: Utils.getScreenHeight(context) - top,
                        color: TDColors.loadingBg,
                        child: Column(
                          children: [dropDownWidget],
                        )),
                    onTap: () {
                      hideDropDownPop();
                    },
                  ),
                  top: top,
                )
              : Container(
                  width: 0,
                  height: 0,
                ),
          showPop
              ? Positioned(
                  child: GestureDetector(
                    child: Container(
                        width: Utils.getScreenWidth(context),
                        height: Utils.getScreenHeight(context),
                        color: TDColors.loadingBg,
                        child: popWidget),
                    onTap: () {
                      if (popFocus) {
                        return;
                      }
                      hidePopWidget();
                    },
                  ),
                  top: 0,
                )
              : Container(
                  width: 0,
                  height: 0,
                ),
        ],
      ),
    );
  }

  bool isLoading() {
    return this._loading;
  }

  showLoading() {
    setState(() {
      _loading = true;
    });
  }

  hideLoading() {
    setState(() {
      _loading = false;
    });
  }

  setTop(double top) {
    setState(() {
      this.top = top;
    });
  }

  showDropDownPop() {
    setState(() {
      this.showDropDown = true;
    });
  }

  //显示全局浮动层
  showPopWidget() {
    setState(() {
      this.showPop = true;
    });
  }

  //设置下拉选框里面的内容
  setDropDownWidget(
    dropDownWidget,
  ) {
    setState(() {
      this.dropDownWidget = dropDownWidget;
    });
  }

  //设置全局浮动层里面的内容
  setPopWidget(Widget popWidget, {popFocus: false}) {
    setState(() {
      this.popWidget = popWidget;
      this.popFocus = popFocus;
    });
  }

  hideDropDownPop() {
    setState(() {
      this.showDropDown = false;
    });
  }

  //隐藏全局浮动层
  hidePopWidget() {
    setState(() {
      this.showPop = false;
    });
  }

  E getPresenter();

  String pageName() {
    return "basePage";
  }

  Widget buildViews(BuildContext context);

  @override
  bool get wantKeepAlive => true;
}
