// Copyright (c) 2022 NetEase, Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:nim_core_v2/nim_core.dart';

class IMKitRouter {
  late Map<String, WidgetBuilder> routes;

  IMKitRouter._() {
    routes = {};
  }

  //是否使用GoRouter
  bool enableGoRouter = false;

  static final IMKitRouter instance = IMKitRouter._();

  //全局的路由监听
  final RouteObserver<Route<dynamic>> routeObserver = RouteObserver();

  bool registerRouter(String name, WidgetBuilder builder,
      {Map<String, Object>? arguments, bool cover = false}) {
    if (routes[name] == null || cover) {
      routes[name] = builder;
      return true;
    }
    return false;
  }

  static T? getArgumentFormMap<T>(BuildContext context, String key) {
    // 如果使用 Go Router，从 queryParameters 获取参数
    if (instance.enableGoRouter) {
      final GoRouterState? state = GoRouterState.of(context);
      if (state != null) {
        if (state.extra is Map) {
          Map<String, Object?> argMap = state.extra as Map<String, Object?>;
          return argMap[key] as T?;
        } else if (state.uri.queryParameters.containsKey(key)) {
          String value = state.uri.queryParameters[key]!;
          // 根据类型转换
          if (T == String) {
            return value as T;
          } else if (T == int) {
            return int.tryParse(value) as T?;
          } else if (T == bool) {
            return (value.toLowerCase() == 'true') as T;
          }
          return value as T?;
        }
      }
      return null;
    }

    // 传统 Navigator 的参数获取方式
    var argument = ModalRoute.of(context)!.settings.arguments;
    if (argument == null || argument is! Map) {
      return null;
    }
    Map<String, Object?> argMap = argument as Map<String, Object?>;
    return argMap[key] as T?;
  }
}
