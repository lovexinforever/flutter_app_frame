import 'dart:async';

import 'package:app_flutter/log/logger.dart';
import 'package:app_flutter/pages/app/app_start.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'global_event.dart';

part 'global_state.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  GlobalBloc() : super(GlobalInitial());

  AppStart appStart = AppStart();

  @override
  Stream<GlobalState> mapEventToState(
    GlobalEvent event,
  ) async* {
    if (event is GlobalInitEvent) {
      Logger.i("app start init");

      appStart.initApp();
    }
  }
}
