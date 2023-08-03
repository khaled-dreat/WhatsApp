part of 'package:whatsapp_ui/utils/import/app_import.dart';

final messageReplyProvider = StateProvider<MessageReply?>((ref) => null);

class MessageReply {
  final String msg;
  final bool isMe;
  final MessageEnum messageEnum;
  MessageReply({
    required this.msg,
    required this.isMe,
    required this.messageEnum,
  });
}
