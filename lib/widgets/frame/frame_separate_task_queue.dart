//
//  frame_separate_task_queue
//  flutter_app_2.0
//
//  Created by dingyang on2021/7/12 .
//  Copyright ©2021/7/12 flutter_app_2.0. All rights reserved.
import 'dart:async';
import 'dart:collection';
import 'dart:developer';
import 'package:app_flutter/log/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';

class FrameSeparateTaskQueue {
  bool _hasRequestedAnEventLoopCallback = false;
  int maxTaskSize = 0;

  FrameSeparateTaskQueue._();

  static FrameSeparateTaskQueue? _instance;

  static FrameSeparateTaskQueue? get instance {
    if (_instance == null) _instance = FrameSeparateTaskQueue._();
    return _instance;
  }

  SchedulingStrategy schedulingStrategy = defaultSchedulingStrategy;

  final Queue<TaskEntry<dynamic>> _taskQueue = ListQueue();

  int get taskLength => _taskQueue.length;

  Future<bool> handleEventLoopCallback() async {
    if (_taskQueue.isEmpty) return false;
    final TaskEntry<dynamic> entry = _taskQueue.first;
    if (schedulingStrategy(
        priority: entry.priority, scheduler: SchedulerBinding.instance!)) {
      try {
        _taskQueue.removeFirst();
        entry.run();
      } catch (exception, exceptionStack) {
        StackTrace? callbackStack;
        assert(() {
          callbackStack = entry.debugStack;
          return true;
        }());
        FlutterError.reportError(FlutterErrorDetails(
          exception: exception,
          stack: exceptionStack,
          library: 'scheduler library',
          context: ErrorDescription('during a task callback'),
          informationCollector: (callbackStack == null)
              ? null
              : () sync* {
            yield DiagnosticsStackTrace(
              '\nThis exception was thrown in the context of a scheduler callback. '
                  'When the scheduler callback was _registered_ (as opposed to when the '
                  'exception was thrown), this was the stack',
              callbackStack,
            );
          },
        ));
      }
      return _taskQueue.isNotEmpty;
    }
    return false;
  }

  // Ensures that the scheduler services a task scheduled by [scheduleTask].
  void _ensureEventLoopCallback() async {
    assert(_taskQueue.isNotEmpty);
    if (_hasRequestedAnEventLoopCallback) return;
    _hasRequestedAnEventLoopCallback = true;
    Timer.run(() {
      _runTasks();
    });
  }

  // Scheduled by _ensureEventLoopCallback.
  void _runTasks() async {
    _hasRequestedAnEventLoopCallback = false;
    await SchedulerBinding.instance!.endOfFrame;
    bool result = await handleEventLoopCallback();
    if (result)
      _ensureEventLoopCallback();
    else {
      if (_taskQueue.isNotEmpty) {
        _ensureEventLoopCallback();
      }
    }
  }

  void shuffleTask(bool Function(TaskEntry taskEntry) condition) {
    _taskQueue.removeWhere((e) => condition(e));
  }

  Future<T> scheduleTask<T>(TaskCallback<T> task, Priority priority,
      {String? debugLabel, Flow? flow, int? id}) {
    final TaskEntry<T> entry =
    TaskEntry<T>(task, priority.value, debugLabel, flow, id: id);
    _addTask(entry);
    _ensureEventLoopCallback();
    return entry.completer.future;
  }

  void _addTask(TaskEntry _taskEntry) {
    if (maxTaskSize != 0 && _taskQueue.length >= maxTaskSize) {
      Logger.i('remove Task');
      _taskQueue.removeFirst();
    }
    _taskQueue.add(_taskEntry);
  }

  void resetMaxTaskSize() {
    maxTaskSize = 0;
  }
}

class TaskEntry<T> {
  TaskEntry(this.task, this.priority, this.debugLabel, this.flow, {this.id}) {
    // ignore: prefer_asserts_in_initializer_lists
    assert(() {
      debugStack = StackTrace.current;
      return true;
    }());
    completer = Completer<T>();
  }

  final TaskCallback<T> task;
  final int priority;
  final String? debugLabel;
  final Flow? flow;
  final int? id;
  StackTrace? debugStack;
  late Completer<T> completer;

  void run() {
    if (!kReleaseMode) {
      Timeline.timeSync(
        debugLabel ?? 'Scheduled Task',
            () {
          completer.complete(task());
        },
        flow: flow != null ? Flow.step(flow!.id) : null,
      );
    } else {
      completer.complete(task());
    }
  }
}