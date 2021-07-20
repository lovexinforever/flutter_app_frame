//
//  bloc_wrapper
//  app_flutter
//
//  Created by dingyang on2021/7/14 .
//  Copyright ©2021/7/14 app_flutter. All rights reserved.

import 'package:app_flutter/bloc/global/global_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// 说明: Bloc提供器包裹层
class BlocWrapper extends StatefulWidget {
  final Widget child;

  BlocWrapper({required this.child});

  @override
  State<StatefulWidget> createState() {
    return _BlocWrapperState();
  }
}

class _BlocWrapperState extends State<BlocWrapper> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<GlobalBloc>(
          create: (_) => GlobalBloc()..add(GlobalInitEvent())),
    ], child: widget.child);
  }
}
