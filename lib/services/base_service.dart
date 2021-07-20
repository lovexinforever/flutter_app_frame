//
//  base_service
//  app_flutter
//
//  Created by dingyang on2021/7/14 .
//  Copyright ©2021/7/14 app_flutter. All rights reserved.
import 'package:flutter/material.dart';

abstract class BaseService<T extends BuildContext> {
  BuildContext _context;

  BaseService(BuildContext buildContext) : _context = buildContext;
}
