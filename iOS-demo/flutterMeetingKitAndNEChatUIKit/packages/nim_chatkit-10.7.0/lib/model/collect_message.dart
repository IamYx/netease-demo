// Copyright (c) 2022 NetEase, Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.
import 'dart:convert';

import 'package:nim_core_v2/nim_core.dart';

class CollectMessage {
  String message;
  String conversationName;
  String senderName;
  String? avatar;

  NIMMessage? nimMessage;

  //搜藏本身
  NIMCollection? collection;

  CollectMessage({
    required this.message,
    required this.conversationName,
    required this.senderName,
    this.avatar,
  });

  factory CollectMessage.fromJson(Map<String, dynamic> json) {
    return CollectMessage(
      message: json['message'] as String? ?? '',
      conversationName: json['conversationName'] as String? ?? '',
      senderName: json['senderName'] as String? ?? '',
      avatar: json['avatar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'conversationName': conversationName,
      'senderName': senderName,
      'avatar': avatar,
    };
  }

  Future<void> deserializationMsg() async {
    nimMessage =
        (await NimCore.instance.messageService.messageDeserialization(message))
            .data;
    return;
  }

  String toJsonString() {
    return json.encode(toJson());
  }

  static CollectMessage? fromJsonString(String jsonString) {
    try {
      return CollectMessage.fromJson(json.decode(jsonString));
    } catch (e) {
      return null;
    }
  }
}

NIMMessageType getMessageTypeForCollectType(int collectType) {
  return V2NIMMessageTypeConverter(messageType: null)
      .fromValue(collectType - 1000);
}

int getCollectTypeForMessageType(NIMMessageType messageType) {
  return V2NIMMessageTypeConverter(messageType: messageType).toValue() + 1000;
}
