//
//  loading_indicator
//  app_flutter
//
//  Created by dingyang on2021/7/14 .
//  Copyright ©2021/7/14 app_flutter. All rights reserved.

import 'package:app_flutter/styles/td_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: TDColors.loadingBg,
      child: Center(
        child: CupertinoActivityIndicator(), //CircularProgressIndicator(),
      ),
    );
  }
}
