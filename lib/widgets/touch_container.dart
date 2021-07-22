//
//  touch_container
//  app_flutter
//
//  Created by dingyang on2021/7/22 .
//  Copyright ©2021/7/22 app_flutter. All rights reserved.

import 'package:app_flutter/log/logger.dart';
import 'package:app_flutter/utils/utils.dart';
import 'package:flutter/material.dart';

class TouchContainer extends StatefulWidget {
  final Widget child;

  final Function? onTap;

  final int? quickTime;

  TouchContainer({required this.child, this.onTap, this.quickTime, Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new TouchContainerState();
  }
}

class TouchContainerState extends State<TouchContainer> {
  DateTime? lastPopTime;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: widget.child,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        if (Utils.isNotEmpty(widget.onTap)) {
          if (Utils.isEmpty(widget.quickTime)) {
            widget.onTap!();
          } else {
            // 防重复提交
            if (lastPopTime == null ||
                DateTime.now().difference(lastPopTime!) >
                    Duration(seconds: widget.quickTime!)) {
              lastPopTime = DateTime.now();
              widget.onTap!();
            } else {
              Logger.w("click too quick!!!!");
            }
          }
        }
      },
    );
  }
}
