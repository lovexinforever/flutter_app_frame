//
//  frame_separate_widget
//  flutter_app_2.0
//
//  Created by dingyang on2021/7/12 .
//  Copyright ©2021/7/12 flutter_app_2.0. All rights reserved.

import 'package:app_flutter/log/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'frame_separate_task_queue.dart';
import 'item_size_info_notifier.dart';
import 'size_cache_widget.dart';

class FrameSeparateWidget extends StatefulWidget {
  final Widget child;

  /// The placeholder widget sets components that are as close to the actual widget as possible
  final Widget? placeHolder;

  /// Identifies its own ID, used in a scenario where size information is stored
  final int? index;

  const FrameSeparateWidget({
    Key? key,
    this.index,
    required this.child,
    this.placeHolder,
  }) : super(key: key);

  @override
  _FrameSeparateWidgetState createState() => _FrameSeparateWidgetState();
}

class _FrameSeparateWidgetState extends State<FrameSeparateWidget> {
  Widget? result;

  @override
  void initState() {
    super.initState();
    result = widget.placeHolder ??
        Container(
          height: 20,
        );
    Map<int?, Size>? size = SizeCacheWidget.of(context)?.itemsSizeCache;
    Size? itemSize;
    if (size != null && size.containsKey(widget.index)) {
      itemSize = size[widget.index];
      Logger.i("cache hit：${widget.index} ${itemSize.toString()}");
    }
    if (itemSize != null) {
      result = Container(
        width: itemSize.width,
        height: itemSize.height,
        child: result,
      );
    }
    transformWidget();
  }

  @override
  void didUpdateWidget(FrameSeparateWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    transformWidget();
  }

  @override
  Widget build(BuildContext context) {
    return ItemSizeInfoNotifier(index: widget.index, child: result);
  }

  void transformWidget() {
    SchedulerBinding.instance!.addPostFrameCallback((t) {
      FrameSeparateTaskQueue.instance!.scheduleTask(() {
        if (mounted)
          setState(() {
            result = widget.child;
          });
      }, Priority.animation, id: widget.index);
    });
  }
}