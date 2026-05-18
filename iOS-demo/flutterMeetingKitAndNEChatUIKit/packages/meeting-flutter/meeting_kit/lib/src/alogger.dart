// Copyright (c) 2022 NetEase, Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:yunxin_alog/yunxin_alog.dart';

class Alogger {
  final String tag;
  final String module;
  final AlogType type;

  const Alogger.api(this.tag, this.module) : type = AlogType.api;

  const Alogger.normal(this.tag, this.module) : type = AlogType.normal;

  void v(String content) {
    Alog.v(tag: tag, type: type, moduleName: module, content: content);
  }

  void d(String content) {
    Alog.d(tag: tag, type: type, moduleName: module, content: content);
  }

  void i(String content) {
    Alog.i(tag: tag, type: type, moduleName: module, content: content);
  }

  void w(String content) {
    Alog.w(tag: tag, type: type, moduleName: module, content: content);
  }

  void e(String content) {
    Alog.e(tag: tag, type: type, moduleName: module, content: content);
  }

  void test(String content) {
    Alog.test(tag: tag, type: type, moduleName: module, content: content);
  }

  void flushSync() {
    Alog.flushSync();
  }

  void flushAsync() {
    Alog.flushAsync();
  }
}
