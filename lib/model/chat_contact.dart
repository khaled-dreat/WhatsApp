// ignore_for_file: public_member_api_docs, sort_constructors_first

part of "../utils/import/app_import.dart";

class ChatContact {
  final String name;
  final String profilePic;
  final String contactId;
  final String lastMessage;
  final DateTime timeSend;
  ChatContact({
    required this.name,
    required this.profilePic,
    required this.contactId,
    required this.lastMessage,
    required this.timeSend,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'profilePic': profilePic,
      'contactId': contactId,
      'lastMessage': lastMessage,
      'timeSend': timeSend.millisecondsSinceEpoch,
    };
  }

  factory ChatContact.fromMap(Map<String, dynamic> map) {
    return ChatContact(
      name: map['name'] as String,
      profilePic: map['profilePic'] as String,
      contactId: map['contactId'] as String,
      lastMessage: map['lastMessage'] as String,
      timeSend: DateTime.fromMillisecondsSinceEpoch(map['timeSend'] as int),
    );
  }
}
