import 'package:uuid/uuid.dart';

class Identity {
  static String currentUserId = "";
  
  static const _uuid = Uuid();

  static String _newId(String prefix) {
    final raw = _uuid.v4().replaceAll('-', '');
    return "${prefix}_$raw";
  }

  static String newUserId() => _newId("usr");
  static String newBotId() => _newId("bot");
  static String newGroupId() => _newId("grp");
  static String newChannelId() => _newId("chn");
  static String newDeviceId() => _newId("dev");
  static String newConversationId() => _newId("cnv");
  static String newMessageId() => _newId("msg");

  static bool isUser(String id) => id.startsWith("usr_");
  static bool isBot(String id) => id.startsWith("bot_");
  static bool isGroup(String id) => id.startsWith("grp_");
  static bool isChannel(String id) => id.startsWith("chn_");
}
