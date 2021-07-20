//
//  app
//  app_flutter
//
//  Created by dingyang on2021/7/14 .
//  Copyright ©2021/7/14 app_flutter. All rights reserved.

import 'package:app_flutter/bloc/global/global_bloc.dart';
import 'package:app_flutter/config/config.dart';
import 'package:app_flutter/pages/welcome/welcome_page.dart';
import 'package:app_flutter/router/td_router.dart';
import 'package:app_flutter/widgets/td_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Config.mContext = context;
    return BlocBuilder<GlobalBloc, GlobalState>(builder: (_, state) {
      return ScreenUtilInit(
        designSize: Size(750, 1334),
        builder: () => OKToast(
            child: MaterialApp(
          title: "TD",
          debugShowCheckedModeBanner: false,
          onGenerateRoute: TDRouter.generateRoute,
          theme: ThemeData(
            // primarySwatch: state.themeColor,
            // fontFamily: state.fontFamily,
            platform: TargetPlatform.iOS,
          ),
          home: WelcomePage(),
        )),
      );
    });
  }
}
