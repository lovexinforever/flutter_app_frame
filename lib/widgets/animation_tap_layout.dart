//
//  animation_tap_layout
//  app_flutter
//
//  Created by dingyang on2021/7/14 .
//  Copyright ©2021/7/14 app_flutter. All rights reserved.

import 'package:app_flutter/utils/utils.dart';
import 'package:flutter/material.dart';

class AnimationTabLayout extends StatefulWidget {
  final Widget child;

  Function? onTap;

  AnimationTabLayout({required this.child, this.onTap});

  @override
  State<StatefulWidget> createState() {
    return new _AnimationTabLayoutState();
  }
}

class _AnimationTabLayoutState extends State<AnimationTabLayout>
    with SingleTickerProviderStateMixin {
  double? _scale;
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller!.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller!.reverse();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller!.value;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTap: _onTap,
      child: Transform.scale(
        scale: _scale!,
        child: widget.child,
      ),
    );
  }

  _onTap() {
    if (Utils.isEmpty(widget.onTap)) {
      return false;
    }

    widget.onTap!();
  }
}
