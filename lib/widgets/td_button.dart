//
//  td_button
//  app_flutter
//
//  Created by dingyang on2021/7/14 .
//  Copyright ©2021/7/14 app_flutter. All rights reserved.
import 'package:app_flutter/utils/utils.dart';
import 'package:flutter/material.dart';

import 'animation_tap_layout.dart';

class TDButton extends StatefulWidget {
  double? height;

  double? width;

  final Color enableBgColor;

  final Color unableBgColor;

  final TextStyle enableTextStyle;

  final TextStyle unableTextStyle;

  Function? onTap;

  bool isEnable;

  final String title;

  final double radius;

  TDButton({
    Key? key,
    this.width,
    this.height,
    this.isEnable: false,
    this.radius = 28,
    this.onTap,
    this.title: "提交",
    this.enableTextStyle =
        const TextStyle(fontSize: 14, color: Color(0xffffffff)),
    this.unableTextStyle =
        const TextStyle(fontSize: 14, color: Color(0xffa7a7a7)),
    this.enableBgColor: const Color(0xffff0000),
    this.unableBgColor: const Color(0xffececec),
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _TDButtonState();
  }
}

class _TDButtonState extends State<TDButton> {
  setIsEnable(bool isEnable) {
    setState(() {
      widget.isEnable = isEnable;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimationTabLayout(
      onTap: () {
        if (!widget.isEnable || Utils.isEmpty(widget.onTap)) {
          return;
        }

        widget.onTap!();
      },
      child: Container(
        alignment: Alignment.center,
        child: ButtonTheme(
          minWidth:
              Utils.isEmpty(widget.width) ? double.infinity : widget.width!,
          height:
              Utils.isEmpty(widget.height) ? double.infinity : widget.height!,
          child: Container(
            child: Text(
              widget.title,
              style: widget.isEnable
                  ? widget.enableTextStyle
                  : widget.unableTextStyle,
            ),
            color:
                widget.isEnable ? widget.enableBgColor : widget.unableBgColor,

          ),
        ),
      ),
    );
  }
}
