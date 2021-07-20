//
//  size_cache_widget
//  flutter_app_2.0
//
//  Created by dingyang on2021/7/12 .
//  Copyright ©2021/7/12 flutter_app_2.0. All rights reserved.

import 'package:flutter/material.dart';

import 'frame_separate_task_queue.dart';
import 'layout_info_notification.dart';

class SizeCacheWidget extends StatefulWidget {
  final Widget child;

  /// Estimate the number of children on the screen, which is used to set the size of the frame queue
  /// Optimizes the list of items on the current screen for delayed response in fast scrolling scenarios
  final int estimateCount;

  const SizeCacheWidget({Key? key, required this.child, this.estimateCount = 0})
      : super(key: key);

  static _SizeCacheWidgetState? of(BuildContext context) {
    return context.findAncestorStateOfType<_SizeCacheWidgetState>();
  }

  @override
  _SizeCacheWidgetState createState() => _SizeCacheWidgetState();
}

class _SizeCacheWidgetState extends State<SizeCacheWidget> {
  /// Stores the Size of the child node's report
  Map<int?, Size> itemsSizeCache = <int?, Size>{};

  @override
  void initState() {
    super.initState();
    setSeparateFramingTaskQueue();
  }

  @override
  void didUpdateWidget(SizeCacheWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    setSeparateFramingTaskQueue();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (ctx) {
        return NotificationListener<LayoutInfoNotification>(
          onNotification: (LayoutInfoNotification notification) {
            // Logger.i(
            //     "size info :  index = ${notification.index}  size = ${notification.size.toString()}");
            saveLayoutInfo(notification.index, notification.size);
            return true;
          },
          child: widget.child,
        );
      },
    );
  }

  void saveLayoutInfo(int? index, Size size) {
    itemsSizeCache[index] = size;
  }

  void setSeparateFramingTaskQueue() {
    if (widget.estimateCount != 0) {
      FrameSeparateTaskQueue.instance!.maxTaskSize = widget.estimateCount;
    }
  }

  @override
  void dispose() {
    FrameSeparateTaskQueue.instance!.resetMaxTaskSize();
    super.dispose();
  }
}