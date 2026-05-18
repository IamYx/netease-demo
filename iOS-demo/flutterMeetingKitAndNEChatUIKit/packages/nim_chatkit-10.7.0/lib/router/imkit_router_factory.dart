// Copyright (c) 2022 NetEase, Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:nim_core_v2/nim_core.dart';

import 'imkit_router.dart';
import 'imkit_router_constants.dart';

/// 跳转到P2P会话页面
/// [userId] 会话ID
/// [anchorDate] 锚点日期
/// [message] 锚点消息
Future<T?> goToP2pChat<T extends Object?>(BuildContext context, String userId,
    {int? anchorDate, NIMMessage? message}) async {
  var conversationId =
      (await NimCore.instance.conversationIdUtil.p2pConversationId(userId))
          .data!;

  if (IMKitRouter.instance.enableGoRouter) {
    return context.pushNamed(RouterConstants.PATH_CHAT_PAGE, extra: {
      'conversationId': conversationId,
      'conversationType': NIMConversationType.p2p,
      'anchor': message,
      'anchorDate': anchorDate,
    });
  }

  return Navigator.pushNamed(context, RouterConstants.PATH_CHAT_PAGE,
      arguments: {
        'conversationId': conversationId,
        'conversationType': NIMConversationType.p2p,
        'anchor': message,
        'anchorDate': anchorDate,
      });
}

/// 跳转到会话页面，并保持首页
void goToChatAndKeepHome(
    BuildContext context, String conversationId, NIMConversationType type,
    {NIMMessage? message, int? anchorDate}) {
  if (IMKitRouter.instance.enableGoRouter) {
    // 先回到首页（清空栈）
    context.go('/');

    // 再 push ChatPage
    Future.microtask(() {
      context.push(
        RouterConstants.PATH_CHAT_PAGE,
        extra: {
          'conversationId': conversationId,
          'conversationType': type,
          'anchor': message,
          'anchorDate': anchorDate,
        },
      );
    });
  } else {
    Navigator.pushNamedAndRemoveUntil(
        context, RouterConstants.PATH_CHAT_PAGE, ModalRoute.withName('/'),
        arguments: {
          'conversationId': conversationId,
          'conversationType': type,
          'anchor': message,
          'anchorDate': anchorDate,
        });
  }
}

/// 跳转到会话页面，并清空栈
void goToChatAndClearStack(
    BuildContext context, String teamConversationId, NIMConversationType type,
    {NIMMessage? message, int? anchorDate}) {
  if (IMKitRouter.instance.enableGoRouter) {
    context.go(
      RouterConstants.PATH_CHAT_PAGE,
      extra: {
        'conversationId': teamConversationId,
        'conversationType': type,
        'anchor': message,
        'anchorDate': anchorDate,
      },
    );
  } else {
    Navigator.pushNamedAndRemoveUntil(context, RouterConstants.PATH_CHAT_PAGE,
        ModalRoute.withName(RouterConstants.PATH_CHAT_PAGE),
        arguments: {
          'conversationId': teamConversationId,
          'conversationType': type,
          'anchor': message,
          'anchorDate': anchorDate,
        });
  }
}

/// 跳转到群聊页面
Future<T?> goToTeamChat<T extends Object?>(BuildContext context, String teamId,
    {NIMMessage? message, int? anchorDate}) async {
  var conversationId =
      (await NimCore.instance.conversationIdUtil.teamConversationId(teamId))
          .data!;

  if (IMKitRouter.instance.enableGoRouter) {
    return context.pushNamed(RouterConstants.PATH_CHAT_PAGE, extra: {
      'conversationId': conversationId,
      'conversationType': NIMConversationType.team,
      'anchor': message,
      'anchorDate': anchorDate,
    });
  }

  return Navigator.pushNamed(context, RouterConstants.PATH_CHAT_PAGE,
      arguments: {
        'conversationId': conversationId,
        'conversationType': NIMConversationType.team,
        'anchor': message,
        'anchorDate': anchorDate,
      });
}

Future<T?> goToChatPage<T extends Object?>(
    BuildContext context, String conversationId, NIMConversationType type,
    {NIMMessage? message, int? anchorDate}) async {
  if (IMKitRouter.instance.enableGoRouter) {
    return context.pushNamed(RouterConstants.PATH_CHAT_PAGE, extra: {
      'conversationId': conversationId,
      'conversationType': type,
      'anchor': message,
      'anchorDate': anchorDate,
    });
  }
  return Navigator.pushNamed(context, RouterConstants.PATH_CHAT_PAGE,
      arguments: {
        'conversationId': conversationId,
        'conversationType': type,
        'anchor': message,
        'anchorDate': anchorDate,
      });
}

Future<T?> goToContactSelector<T extends Object?>(BuildContext context,
    {int? mostCount,
    List<String>? filter,
    bool? returnContact,
    bool? includeAIUser}) {
  if (IMKitRouter.instance.enableGoRouter) {
    return context
        .pushNamed(RouterConstants.PATH_CONTACT_SELECTOR_PAGE, extra: {
      'mostCount': mostCount,
      'filterUser': filter,
      'returnContact': returnContact,
      'includeAIUser': includeAIUser
    });
  }
  return Navigator.pushNamed(
      context, RouterConstants.PATH_CONTACT_SELECTOR_PAGE,
      arguments: {
        'mostCount': mostCount,
        'filterUser': filter,
        'returnContact': returnContact,
        'includeAIUser': includeAIUser
      });
}

Future<T?> goToContactDetail<T extends Object?>(
    BuildContext context, String accId) {
  if (IMKitRouter.instance.enableGoRouter) {
    return context.pushNamed(RouterConstants.PATH_USER_INFO_PAGE,
        extra: {'accId': accId});
  }
  return Navigator.pushNamed(context, RouterConstants.PATH_USER_INFO_PAGE,
      arguments: {'accId': accId});
}

Future<T?> goToTeamDetail<T extends Object?>(
    BuildContext context, String teamId) {
  if (IMKitRouter.instance.enableGoRouter) {
    return context.pushNamed(RouterConstants.PATH_TEAM_DETAIL_PAGE,
        extra: {'teamId': teamId});
  }
  return Navigator.pushNamed(context, RouterConstants.PATH_TEAM_DETAIL_PAGE,
      arguments: {'teamId': teamId});
}

Future<T?> goToTeamMemberList<T extends Object?>(
    BuildContext context, String teamId,
    {bool showOwnerAndManager = true,
    bool isGroupTeam = false,
    bool isMultiSelectModel = false,
    bool singleSelect = false,
    bool showAIMember = true,
    bool showRole = true,
    int? maxSelectMemberCount,
    bool showRemoveButton = true}) {
  if (IMKitRouter.instance.enableGoRouter) {
    return context.pushNamed(RouterConstants.PATH_TEAM_MEMBER_PAGE, extra: {
      'teamId': teamId,
      'showOwnerAndManager': showOwnerAndManager,
      'isGroupTeam': isGroupTeam,
      'isMultiSelectModel': isMultiSelectModel,
      'singleSelect': singleSelect,
      'showAIMember': showAIMember,
      'showRemoveButton': showRemoveButton,
      'maxSelectMemberCount': maxSelectMemberCount,
      'showRole': showRole
    });
  }
  return Navigator.pushNamed(context, RouterConstants.PATH_TEAM_MEMBER_PAGE,
      arguments: {
        'teamId': teamId,
        'showOwnerAndManager': showOwnerAndManager,
        'isGroupTeam': isGroupTeam,
        'isMultiSelectModel': isMultiSelectModel,
        'singleSelect': singleSelect,
        'showAIMember': showAIMember,
        'showRemoveButton': showRemoveButton,
        'maxSelectMemberCount': maxSelectMemberCount,
        'showRole': showRole
      });
}

Future<T?> gotoMineInfoPage<T extends Object?>(BuildContext context) {
  if (IMKitRouter.instance.enableGoRouter) {
    return context.pushNamed(RouterConstants.PATH_MINE_INFO_PAGE);
  }
  return Navigator.pushNamed<T>(context, RouterConstants.PATH_MINE_INFO_PAGE);
}

Future<T?> goTeamListPage<T extends Object?>(BuildContext context,
    {bool? selectorModel}) {
  if (IMKitRouter.instance.enableGoRouter) {
    return context.pushNamed(RouterConstants.PATH_MY_TEAM_PAGE,
        extra: {'selectorModel': selectorModel});
  }
  return Navigator.pushNamed(context, RouterConstants.PATH_MY_TEAM_PAGE,
      arguments: {'selectorModel': selectorModel});
}

Future<T?> goAddFriendPage<T extends Object?>(
  BuildContext context,
) {
  if (IMKitRouter.instance.enableGoRouter) {
    return context.pushNamed(RouterConstants.PATH_ADD_FRIEND_PAGE);
  }
  return Navigator.pushNamed(context, RouterConstants.PATH_ADD_FRIEND_PAGE);
}

Future<T?> goGlobalSearchPage<T extends Object?>(
  BuildContext context,
) {
  if (IMKitRouter.instance.enableGoRouter) {
    return context.pushNamed(RouterConstants.PATH_GLOBAL_SEARCH_PAGE);
  }
  return Navigator.pushNamed(context, RouterConstants.PATH_GLOBAL_SEARCH_PAGE);
}

/// 跳转到聊天历史记录页面
Future<T?> goToTeamChatHistoryPage<T extends Object?>(
    BuildContext context, String teamId) {
  if (IMKitRouter.instance.enableGoRouter) {
    return context.pushNamed(RouterConstants.PATH_CHAT_SEARCH_PAGE,
        extra: {'teamId': teamId});
  }
  return Navigator.pushNamed(context, RouterConstants.PATH_CHAT_SEARCH_PAGE,
      arguments: {'teamId': teamId});
}

/// 跳转到收藏消息页面
Future<T?> goToCollectionListPage<T extends Object?>(BuildContext context) {
  if (IMKitRouter.instance.enableGoRouter) {
    return context.pushNamed(RouterConstants.PATH_CHAT_COLLECTION_LIST_PAGE);
  }
  return Navigator.pushNamed(
      context, RouterConstants.PATH_CHAT_COLLECTION_LIST_PAGE);
}

/// 跳转到群设置页面
Future<T?> goToTeamSettingPage<T extends Object?>(
    BuildContext context, String teamId) {
  if (IMKitRouter.instance.enableGoRouter) {
    return context.pushNamed(RouterConstants.PATH_TEAM_SETTING_PAGE,
        extra: {'teamId': teamId});
  }
  return Navigator.pushNamed(context, RouterConstants.PATH_TEAM_SETTING_PAGE,
      arguments: {'teamId': teamId});
}

/// 跳转到Pin 消息页面
Future<T?> goToPinPage<T extends Object?>(BuildContext context,
    String conversationId, NIMConversationType type, String title) {
  if (IMKitRouter.instance.enableGoRouter) {
    return context.pushNamed(RouterConstants.PATH_CHAT_PIN_PAGE, extra: {
      'conversationId': conversationId,
      'conversationType': type,
      'chatTitle': title
    });
  }
  return Navigator.pushNamed(context, RouterConstants.PATH_CHAT_PIN_PAGE,
      arguments: {
        'conversationId': conversationId,
        'conversationType': type,
        'chatTitle': title
      });
}

/// 跳转到聊天历史记录页面
Future<T?> goToChatHistoryPage<T extends Object?>(
    BuildContext context, String conversationId, NIMConversationType type) {
  if (IMKitRouter.instance.enableGoRouter) {
    return context.pushNamed(RouterConstants.PATH_CHAT_HISTORY_PAGE, extra: {
      'conversationId': conversationId,
      'conversationType': type,
    });
  }
  return Navigator.pushNamed(context, RouterConstants.PATH_CHAT_HISTORY_PAGE,
      arguments: {
        'conversationId': conversationId,
        'conversationType': type,
      });
}
