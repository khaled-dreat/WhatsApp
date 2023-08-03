// ignore_for_file: public_member_api_docs, sort_constructors_first

part of "../utils/import/app_import.dart";

class MessageModel {
  final String senderId;
  final String receverId;
  final String messageId;
  final String text;
  final MessageEnum type;
  final DateTime timeSend;
  final bool isSeen;
  final String repliedMessage;
  final String repliedTo;
  final MessageEnum repliedMessageType;

  MessageModel({
    required this.senderId,
    required this.receverId,
    required this.messageId,
    required this.text,
    required this.type,
    required this.timeSend,
    required this.isSeen,
    required this.repliedMessage,
    required this.repliedTo,
    required this.repliedMessageType,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderId': senderId,
      'receverId': receverId,
      'messageId': messageId,
      'text': text,
      'type': type.type,
      'timeSend': timeSend.millisecondsSinceEpoch,
      'isSeen': isSeen,
      'repliedMessage': repliedMessage,
      'repliedMessageType': repliedMessageType.type,
      'repliedTo': repliedTo,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      senderId: map['senderId'] as String,
      receverId: map['receverId'] as String,
      messageId: map['messageId'] as String,
      text: map['text'] as String,
      type: (map['type'] as String).toEnum(),
      timeSend: DateTime.fromMillisecondsSinceEpoch(map['timeSend'] as int),
      isSeen: map['isSeen'] as bool,
      repliedMessage: map['repliedMessage'] ?? '',
      repliedMessageType: (map['repliedMessageType'] as String).toEnum(),
      repliedTo: map['repliedTo'] ?? '',
    );
  }
}
