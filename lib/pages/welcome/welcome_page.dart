//
//  welcome_page
//  app_flutter
//
//  Created by dingyang on2021/7/20 .
//  Copyright ©2021/7/20 app_flutter. All rights reserved.

import 'dart:io';

import 'package:app_flutter/base/base_stateful_page.dart';
import 'package:app_flutter/bloc/welcome/welcome_bloc.dart';
import 'package:app_flutter/model/model/params.dart';
import 'package:app_flutter/pages/welcome/welcome_page_contract.dart';
import 'package:app_flutter/pages/welcome/welcome_page_presenter.dart';
import 'package:app_flutter/styles/td_styles.dart';
import 'package:app_flutter/utils/utils.dart';
import 'package:app_flutter/widgets/touch_container.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprintf/sprintf.dart';

class WelcomePage extends BaseStatefulPage {
  @override
  State<StatefulWidget> createState() {
    return _WelcomePageState();
  }
}

class _WelcomePageState
    extends BaseStatefulPageState<WelcomePage, WelcomePagePresenter>
    implements IWelcomePageView {
  Widget welcomePage = Container();

  /// 倒计时的按钮
  Widget countDownWidget = Container();

  TapGestureRecognizer tapGestureRecognizer = new TapGestureRecognizer();
  TapGestureRecognizer tapGestureRecognizer1 = new TapGestureRecognizer();

  @override
  WelcomePagePresenter getPresenter() {
    return WelcomePagePresenter(this);
  }

  @override
  void netRequest() {
    // TODO: implement netRequest
  }

  @override
  Widget page(BuildContext context) {
    return BlocBuilder<WelcomeBloc, WelcomeState>(builder: (_, state) {
      mPresenter!.handlePageState(state);
      return new Stack(
        children: <Widget>[
          welcomePage,
          Positioned(
            top: 30.0,
            right: 30.0,
            child: countDownWidget,
          )
        ],
      );
    });
  }

  @override
  void pageBeginMethod() {
    loadEnd();
  }

  @override
  void pageDidMethod() {
    // TODO: implement pageDidMethod
  }

  @override
  void pageEndMethod() {
    mPresenter!.destroy();
  }

  @override
  void buildAgreement() {
    setPopWidget(
        Center(
          child: Container(
            width: 270,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.white,
            ),
            constraints: BoxConstraints(maxHeight: 328.5),
            child: Column(
              children: [
                SizedBox(
                  height: 22,
                ),
                Text("用户协议和隐私政策",
                    style: TextStyle(fontSize: 16, color: TDColors.black49)),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: RichText(
                      text: TextSpan(
                          style:
                              TextStyle(fontSize: 14, color: TDColors.black49),
                          text: "1、您将使用典则读书提供的听读等服务，请您务必审慎阅读、充分理解",
                          children: [
                            TextSpan(
                                text: "《服务协议》",
                                style: TextStyle(
                                    fontSize: 14, color: TDColors.primary),
                                recognizer: tapGestureRecognizer
                                  ..onTap = () {
                                    // HtmlModel model = new HtmlModel();
                                    // model.title = "服务协议";
                                    // model.htmlContent = "";
                                    // model.type = 0;
                                    // NavigatorUtils.go2UserRule(context, model);
                                  }),
                            TextSpan(
                                text: "和",
                                style: TextStyle(
                                    fontSize: 14, color: TDColors.black49)),
                            TextSpan(
                                text: "《隐私政策》",
                                style: TextStyle(
                                    fontSize: 14, color: TDColors.primary),
                                recognizer: tapGestureRecognizer1
                                  ..onTap = () {
                                    // HtmlModel model = new HtmlModel();
                                    // model.title = "隐私政策";
                                    // model.htmlContent = "";
                                    // model.type = 1;
                                    // NavigatorUtils.go2UserRule(context, model);
                                  }),
                            TextSpan(
                                text:
                                    "\n2、为了保证您的正常使用，在使用过程中，典则读书需要获取以下权限：访问网络、设备信息、获取位置、相机、存储空间、麦克风等权限。这些权限典则读书APP不会默认开启，只有您在使用过程中同意并授权后才会生效。未经授权我们不会收集、处理或泄露您的个人信息。",
                                style: TextStyle(
                                    fontSize: 14, color: TDColors.black49)),
                          ]),
                    ),
                  ),
                  flex: 1,
                ),
                Container(
                  height: 44,
                  decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Color(0xffe6e6e6))),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TouchContainer(
                          child: Container(
                            child: Text(
                              "不同意",
                              style: TextStyle(
                                  fontSize: 16, color: TDColors.black49),
                            ),
                            alignment: Alignment.center,
                          ),
                          onTap: () {
                            exit(0);
                          },
                        ),
                        flex: 1,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                left: BorderSide(color: Color(0xffe6e6e6)))),
                      ),
                      Expanded(
                        child: TouchContainer(
                          child: Container(
                            child: Text(
                              "同意",
                              style: TextStyle(
                                  fontSize: 16, color: TDColors.primary),
                            ),
                            alignment: Alignment.center,
                          ),
                          onTap: () {
                            // mPresenter.initFirst();
                            go2MainPage();
                            mPresenter!.agreement();
                          },
                        ),
                        flex: 1,
                      )
                    ],
                  ),
                )
              ],
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          ),
        ),
        popFocus: true);
    showPopWidget();
  }

  @override
  void buildCountDownWidget(int count) {
    mySetState(() {
      this.countDownWidget = ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: GestureDetector(
            child: Container(
              child: Text(
                sprintf("跳过%s", [count.toString()]),
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 15.0,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                ),
              ),
              color: Colors.black26,
              padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            ),
            onTap: () {
              go2MainPage();
            },
          ));
    });
  }

  @override
  void buildWelcomePage(String pageImg, String linkType, String linkUrl,
      String linkCode, Params? params) {
    welcomePage = Container(
      child: TouchContainer(
        child: CachedNetworkImage(
          imageUrl: pageImg,
          width: Utils.getScreenWidth(context),
          height: Utils.getScreenHeight(context),
          fit: BoxFit.fill,
          memCacheHeight: 1000,
          memCacheWidth: 1000,
        ),
        onTap: () {
          // go2MainPage(context);
          // DzJump.jump(context,
          //     linkType: store.state.welcomePageInfo?.linkType,
          //     linkCode: store.state.welcomePageInfo?.linkCode,
          //     params: store.state.welcomePageInfo?.params);
        },
      ),
      color: Colors.white,
    );
  }

  @override
  void buildWelcomePageEmpty() {
    welcomePage = Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
    );
  }

  @override
  void go2MainPage() {
    // TODO: implement go2MainPage
  }
}
