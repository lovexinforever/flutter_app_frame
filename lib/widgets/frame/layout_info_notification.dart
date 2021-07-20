//
//  layout_info_notification
//  flutter_app_2.0
//
//  Created by dingyang on2021/7/12 .
//  Copyright ©2021/7/12 flutter_app_2.0. All rights reserved.
import 'dart:ui';

import 'package:flutter/material.dart';

class LayoutInfoNotification extends Notification {
  final Size size;
  final int? index;

  LayoutInfoNotification(this.index, this.size);
}
