//
//  item_size_info_notifier
//  flutter_app_2.0
//
//  Created by dingyang on2021/7/12 .
//  Copyright ©2021/7/12 flutter_app_2.0. All rights reserved.
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'layout_info_notification.dart';


class ItemSizeInfoNotifier extends SingleChildRenderObjectWidget {
  final int? index;

  const ItemSizeInfoNotifier({
    Key? key,
    required this.index,
    required Widget? child,
  }) : super(key: key, child: child);

  @override
  _InitialRenderSizeChangedWithCallback createRenderObject(
      BuildContext context) {
    return _InitialRenderSizeChangedWithCallback(
        onLayoutChangedCallback: (size) {
          LayoutInfoNotification(index, size).dispatch(context);
        });
  }
}

class _InitialRenderSizeChangedWithCallback extends RenderProxyBox {
  _InitialRenderSizeChangedWithCallback({
    RenderBox? child,
    required this.onLayoutChangedCallback,
  })  : assert(onLayoutChangedCallback != null),
        super(child);

  final Function(Size size) onLayoutChangedCallback;

  Size? _oldSize;

  @override
  void performLayout() {
    super.performLayout();
    if (size != _oldSize) onLayoutChangedCallback(size);
    _oldSize = size;
  }
}