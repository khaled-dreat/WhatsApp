// ignore_for_file: public_member_api_docs, sort_constructors_first
part of "../../../utils/import/app_import.dart";

final chatrepositoryProvider = Provider((ref) => ChatRepostry(
    firestore: FirebaseFirestore.instance, auth: FirebaseAuth.instance));

class ChatRepostry {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  ChatRepostry({
    required this.firestore,
    required this.auth,
  });
  Stream<List<ChatContact>> getChatContact() {
    return firestore
        .collection('user')
        .doc(auth.currentUser!.uid)
        .collection('chat')
        .snapshots()
        .asyncMap(
      (event) async {
        List<ChatContact> contact = [];
        for (var document in event.docs) {
          var chatContact = ChatContact.fromMap(document.data());
          var userData = await firestore
              .collection('user')
              .doc(chatContact.contactId)
              .get();
          var user = UserModel.fromMap(userData.data()!);
          contact.add(ChatContact(
              name: user.name,
              profilePic: user.profilePic,
              contactId: chatContact.contactId,
              lastMessage: chatContact.lastMessage,
              timeSend: chatContact.timeSend));
        }
        return contact;
      },
    );
  }

  Stream<List<MessageModel>> getChatStream(String reciverUserId) {
    return firestore
        .collection('user')
        .doc(auth.currentUser!.uid)
        .collection('chat')
        .doc(reciverUserId)
        .collection('message')
        .orderBy('timeSend')
        .snapshots()
        .map((event) {
      List<MessageModel> messages = [];
      for (var document in event.docs) {
        messages.add(MessageModel.fromMap(document.data()));
      }
      return messages;
    });
  }

  void _saveDataToContactsSubcollection(
      UserModel senderUserData,
      UserModel recieverUserData,
      String text,
      DateTime timeSend,
      String reciverUserId) async {
    var recieverChatContact = ChatContact(
        name: senderUserData.name,
        profilePic: senderUserData.profilePic,
        contactId: senderUserData.uid,
        lastMessage: text,
        timeSend: timeSend);
    await firestore
        .collection('user')
        .doc(reciverUserId)
        .collection('chat')
        .doc(auth.currentUser!.uid)
        .set(recieverChatContact.toMap());
    //************************************ */
    var senderChatContact = ChatContact(
        name: recieverUserData.name,
        profilePic: recieverUserData.profilePic,
        contactId: recieverUserData.uid,
        lastMessage: text,
        timeSend: timeSend);
    await firestore
        .collection('user')
        .doc(auth.currentUser!.uid)
        .collection('chat')
        .doc(reciverUserId)
        .set(senderChatContact.toMap());
  }

  void _saveMessageToMrssaheSubcollection({
    required String reciverUserId,
    required String text,
    required String messageId,
    required String username,
    required String senderUserName,
    required String receverUsername,
    required DateTime timeSend,
    required MessageEnum messageType,
    required MessageReply? messageReply,
    required receverUserName,
  }) async {
    // print(text);

    final message = MessageModel(
        senderId: auth.currentUser!.uid,
        receverId: reciverUserId,
        messageId: messageId,
        text: text,
        type: messageType,
        timeSend: timeSend,
        isSeen: false,
        repliedTo: messageReply == null
            ? ''
            : messageReply.isMe
                ? senderUserName
                : receverUsername,
        repliedMessageType:
            messageReply == null ? MessageEnum.text : messageReply.messageEnum,
        repliedMessage: messageReply == null ? "" : messageReply.msg);

    await firestore
        .collection('user')
        .doc(auth.currentUser!.uid)
        .collection('chat')
        .doc(reciverUserId)
        .collection('message')
        .doc(messageId)
        .set(message.toMap());

    await firestore
        .collection('user')
        .doc(reciverUserId)
        .collection('chat')
        .doc(auth.currentUser!.uid)
        .collection('message')
        .doc(messageId)
        .set(message.toMap());
  }

  void sendTextMessage({
    required BuildContext context,
    required String text,
    required String recieverUserId,
    required UserModel senderUser,
    required MessageReply? messageReply,
  }) async {
    try {
      var timeSend = DateTime.now();
      UserModel recieverUserData;
      var userDataMap =
          await firestore.collection('user').doc(recieverUserId).get();
      var messageId = const Uuid().v4();
      recieverUserData = UserModel.fromMap(userDataMap.data()!);
      _saveDataToContactsSubcollection(
          senderUser, recieverUserData, text, timeSend, recieverUserId);
      _saveMessageToMrssaheSubcollection(
          reciverUserId: recieverUserId,
          text: text,
          messageId: messageId,
          username: senderUser.name,
          timeSend: timeSend,
          messageType: MessageEnum.text,
          receverUserName: recieverUserData.name,
          messageReply: messageReply,
          receverUsername: recieverUserData.name,
          senderUserName: senderUser.name);
    } catch (e) {
      showSnackBar(context: context, msg: e.toString());
    }
  }

  void sendFileMesssage({
    required BuildContext context,
    // * يستخدم لأختيار الملف الذي سيتم تحميله الى ferebase
    required File file,
    required String reciverUserId,
    required UserModel senderUserData,
    required MessageReply? messageReply,
    required ProviderRef ref,
    //* يستخدم لتحديد نوع الرسالة
    required MessageEnum messageEnum,
  }) async {
    try {
      var timesend = DateTime.now();
      var messageId = const Uuid().v1();
      // * يستخدم لتخزين رابط الملف الذي تم رفعه الى ferebase
      String imageUrl = await ref
          .read(commonFirebaseStorageRepositoryprovider)
          // * دالة رفع الملف الى firebase
          .storageFileTOFirebase(
              'chat/${messageEnum.type}/${senderUserData.uid}/$reciverUserId/$messageId',
              file);

      //* يستخدم لأسناد قيم المستلم من خلال uId من firebase
      UserModel recieverUserData;
      //* الحصول على بيانات المستلم من firebase ثم اسنادهة الى متغير من نوع UserModel
      var userDataMap =
          await firestore.collection('user').doc(reciverUserId).get();
      recieverUserData = UserModel.fromMap(userDataMap.data()!);
      //* تقوم بتحديد نوع الرسالة ثم اسنادهة الى contactMsg
      String contactMsg;
      switch (messageEnum) {
        case MessageEnum.image:
          contactMsg = '📷 Photo';
          break;
        case MessageEnum.video:
          contactMsg = '📸 Video';
          break;
        case MessageEnum.audio:
          contactMsg = '🎵 Audio';
          break;
        case MessageEnum.gif:
          contactMsg = 'Gif';
          break;

        default:
          contactMsg = 'Gif';
      }
      //* تقوم بأسناد  معلومات الرسالة ظمن مجموعة رسائل المستخدم في  firebase
      _saveDataToContactsSubcollection(senderUserData, recieverUserData,
          contactMsg, timesend, reciverUserId);
      //* تقوم بحفظ  معلومات الرسالة في firebase

      _saveMessageToMrssaheSubcollection(
          reciverUserId: reciverUserId,
          text: imageUrl,
          messageId: messageId,
          username: senderUserData.name,
          timeSend: timesend,
          messageType: messageEnum,
          receverUserName: recieverUserData.name,
          messageReply: messageReply,
          receverUsername: recieverUserData.name,
          senderUserName: senderUserData.name);
    } catch (e) {
      showSnackBar(context: context, msg: e.toString());
    }
  }

  void sendGIFMessage({
    required BuildContext context,
    required String gifUrl,
    required String recieverUserId,
    required UserModel senderUser,
    required MessageReply? messageReply,
  }) async {
    try {
      var timeSend = DateTime.now();
      UserModel recieverUserData;
      var userDataMap =
          await firestore.collection('user').doc(recieverUserId).get();
      var messageId = const Uuid().v4();
      recieverUserData = UserModel.fromMap(userDataMap.data()!);
      _saveDataToContactsSubcollection(
          senderUser, recieverUserData, "GIF", timeSend, recieverUserId);
      _saveMessageToMrssaheSubcollection(
          reciverUserId: recieverUserId,
          text: gifUrl,
          messageId: messageId,
          username: senderUser.name,
          timeSend: timeSend,
          messageType: MessageEnum.gif,
          receverUserName: recieverUserData.name,
          messageReply: messageReply,
          receverUsername: recieverUserData.name,
          senderUserName: senderUser.name);
    } catch (e) {
      showSnackBar(context: context, msg: e.toString());
    }
  }

  void sc() {
    dev.log("sendFileMessage_repostre");
  }

  void sendFileMessage({
    required BuildContext context,
    // * يستخدم لأختيار الملف الذي سيتم تحميله الى ferebase
    required File file,
    required String reciverUserId,
    required UserModel senderUserData,
    required MessageReply? messageReply,
    required ProviderRef ref,
    //* يستخدم لتحديد نوع الرسالة
    required MessageEnum messageEnum,
  }) async {
    dev.log("sendFileMessage_repostre");

    try {
      var timesend = DateTime.now();
      var messageId = const Uuid().v1();
      // * يستخدم لتخزين رابط الملف الذي تم رفعه الى ferebase
      String imageUrl = await ref
          .read(commonFirebaseStorageRepositoryprovider)
          // * دالة رفع الملف الى firebase
          .storageFileTOFirebase(
              'chat/${messageEnum.type}/${senderUserData.uid}/$reciverUserId/$messageId',
              file);

      //* يستخدم لأسناد قيم المستلم من خلال uId من firebase
      UserModel recieverUserData;
      //* الحصول على بيانات المستلم من firebase ثم اسنادهة الى متغير من نوع UserModel
      var userDataMap =
          await firestore.collection('user').doc(reciverUserId).get();
      recieverUserData = UserModel.fromMap(userDataMap.data()!);
      //* تقوم بتحديد نوع الرسالة ثم اسنادهة الى contactMsg
      String contactMsg;
      switch (messageEnum) {
        case MessageEnum.image:
          contactMsg = '📷 Photo';
          break;
        case MessageEnum.video:
          contactMsg = '📸 Video';
          break;
        case MessageEnum.audio:
          contactMsg = '🎵 Audio';
          break;
        case MessageEnum.gif:
          contactMsg = 'Gif';
          break;

        default:
          contactMsg = 'Gif';
      }
      //* تقوم بأسناد  معلومات الرسالة ظمن مجموعة رسائل المستخدم في  firebase
      _saveDataToContactsSubcollection(senderUserData, recieverUserData,
          contactMsg, timesend, reciverUserId);
      //* تقوم بحفظ  معلومات الرسالة في firebase

      _saveMessageToMrssaheSubcollection(
          reciverUserId: reciverUserId,
          text: imageUrl,
          messageId: messageId,
          username: senderUserData.name,
          timeSend: timesend,
          messageType: messageEnum,
          receverUserName: recieverUserData.name,
          messageReply: messageReply,
          receverUsername: recieverUserData.name,
          senderUserName: senderUserData.name);
    } catch (e) {
      showSnackBar(context: context, msg: e.toString());
    }
  }

  void setChatMessageSeen(
      BuildContext context, String recverUserId, String messageId) async {
    try {
      await firestore
          .collection('user')
          .doc(auth.currentUser!.uid)
          .collection('chat')
          .doc(recverUserId)
          .collection('message')
          .doc(messageId)
          .update({'isSeen': true});

      await firestore
          .collection('user')
          .doc(recverUserId)
          .collection('chat')
          .doc(auth.currentUser!.uid)
          .collection('message')
          .doc(messageId)
          .update({'isSeen': true});
    } catch (e) {
      showSnackBar(context: context, msg: e.toString());
    }
  }
}
