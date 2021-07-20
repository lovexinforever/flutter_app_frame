//
//  base_stateful_state
//  app_flutter
//
//  Created by dingyang on2021/7/14 .
//  Copyright ©2021/7/14 app_flutter. All rights reserved.

import 'package:app_flutter/router/navigator_utils.dart';
import 'package:app_flutter/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart' as OkToast;
import 'base_contract.dart';
import 'base_state.dart';

abstract class BaseStatefulPage extends StatefulWidget {
  const BaseStatefulPage({Key? key}) : super(key: key);
}

abstract class BaseStatefulPageState<T extends BaseStatefulPage,
        M extends IBasePresenter> extends BaseState<T, M> // with PageLifeCycle
    implements
        IBaseView {
  // GlobalKey titleKey = new GlobalKey();
  bool _loading = true;

  //给子类实现的页面开始方法
  @protected
  void pageBeginMethod();

  //给子类实现的页面结束方法
  @protected
  void pageEndMethod();

  //didChangeDependencies
  @protected
  void pageDidMethod();

  //页面视图
  @protected
  void netRequest();

  @protected
  Widget page(BuildContext context);

  //常用视图1
  Widget pageScaffold(title,
      {Widget? leading,
      Color backgroundColor = Colors.white,
      Widget? body,
      EdgeInsetsGeometry? padding,
      List<Widget>? appBarActions,
      Widget? bottom,
      bool? resizeToAvoidBottomInset,
      EdgeInsetsGeometry? margin,
      GlobalKey? key,
      double? elevation,
      bool bottomLine = true,
      bool back = true,
      double? toolbarHeight,
      double? leadingWith,
      Function? backFunction,
      Color titleColor = const Color(0xff494949)}) {
    return new Scaffold(
      backgroundColor: backgroundColor,
      appBar: new AppBar(
        leadingWidth: leadingWith ?? 40.0,
        key: key ?? new GlobalKey(),
        toolbarHeight: toolbarHeight,
        // leading: back
        //     ? leading ??
        //     new IconButton(
        //         iconSize: 10.0,
        //         padding: EdgeInsets.all(0),
        //         icon: new Icon(
        //           TDICons.New_BACK,
        //           size: 15,
        //           color: TDColors.black49,
        //         ),
        //         onPressed: () {
        //           if (Utils.isNotEmpty(backFunction)) {
        //             backFunction!();
        //           } else {
        //             Navigator.pop(context);
        //           }
        //         })
        //     : Container(),
        elevation: bottomLine ? elevation ?? 0.5 : 0,
        centerTitle: true,
        titleSpacing: 0,
        backgroundColor: backgroundColor,
        title: new Text(
          title,
          style: new TextStyle(color: titleColor, fontSize: 17),
        ),
        actions: appBarActions,
        // bottom: bottom ?? Widget(),
      ),
      body: new Container(
        padding: padding,
        margin: margin,
        child: body,
        color: Colors.white,
      ),
      resizeToAvoidBottomInset:
          resizeToAvoidBottomInset == null ? true : resizeToAvoidBottomInset,
    );
  }

  //加载框

  void loadFalse() {
    if (!mounted) {
      return;
    }

    setState(() {
      _loading = false;
    });
  }

  checkNet() async {
    // var connectivityResult = await (new Connectivity().checkConnectivity());
    // if (connectivityResult == ConnectivityResult.none) {
    //   if (!_loading) {
    //     return;
    //   }
    //   _isNet = false;
    //   mySetState(() {});
    // }
  }

  @override
  void initState() {
    super.initState();
    // Global.setContext(context);
    pageBeginMethod();
    checkNet();
  }

//  void hideBack(){
//    back=false;
//  }

  @override
  void dispose() {
    pageEndMethod();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    pageDidMethod();

    super.didChangeDependencies();
  }

  void mySetState(VoidCallback fn) {
    if (!mounted) {
      return;
    }
    setState(fn);
  }

  @override
  Widget buildViews(BuildContext context) {
    return _loading
        ? new Scaffold(
            body: new LoadingIndicator(),
            appBar: new AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              // leading: IconButton(
              //     iconSize: 10.0,
              //     padding: EdgeInsets.all(0),
              //     icon: new Icon(
              //       TDICons.New_BACK,
              //       size: 15,
              //       color: TDColors.black49,
              //     ),
              //     onPressed: () {
              //       Navigator.pop(context);
              //     }),
            ))
        : page(context);
  }

  void back() {
    Navigator.pop(context);
  }

  @override
  showToast(String message) {
    OkToast.showToast(message, position: OkToast.ToastPosition.bottom);
  }

  @override
  goBack() {
    NavigatorUtils.goBack(context);
  }

  @override
  showLoading() {
    super.showLoading();
  }

  @override
  void didUpdateWidget(covariant T oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  hideLoading() {
    super.hideLoading();
  }

  @override
  loadEnd() {
    loadFalse();
  }
}
