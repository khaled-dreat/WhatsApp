part of "../../../utils/import/app_import.dart";

final chatControllerProvider = Provider((ref) {
  final chatRepository = ref.watch(chatrepositoryProvider);
  return ChatController(
    chatRepostry: chatRepository,
    ref: ref,
  );
});

class ChatController {
  final ChatRepostry chatRepostry;
  final ProviderRef ref;
  ChatController({
    required this.chatRepostry,
    required this.ref,
  });
  void sendTextMessage(
      BuildContext context, String text, String recieverUserId) {
    final messageReply = ref.read(messageReplyProvider);
    ref.read(userDataAuthProvider).whenData((value) =>
        chatRepostry.sendTextMessage(
            context: context,
            text: text,
            recieverUserId: recieverUserId,
            senderUser: value!,
            messageReply: messageReply));
    ref.read(messageReplyProvider.notifier).update((state) => null);
  }

  void sendFileMessage(BuildContext context, String recverUserId,
      MessageEnum messageEnum, File file) {
    dev.log("sendFileMessage_conrtoller");
    final messageReply = ref.read(messageReplyProvider);

    ref.read(userDataAuthProvider).whenData((value) =>
        chatRepostry.sendFileMessage(
            context: context,
            file: file,
            reciverUserId: recverUserId,
            senderUserData: value!,
            ref: ref,
            messageEnum: messageEnum,
            messageReply: messageReply));
    ref.read(messageReplyProvider.notifier).update((state) => null);
  }

  void sendGIFMessage(
      BuildContext context, String recverUserId, String gifUrl) {
    final messageReply = ref.read(messageReplyProvider);

    int gifUrlPartIndex = gifUrl.lastIndexOf('-') + 1;
    String gifUrlPart = gifUrl.substring(gifUrlPartIndex);
    // *     String newgifUrl = 'https://i.giphy.com/media/$gifUrlPart/200.gif';

    String newGifUrl = 'https://i.giphy.com/media/$gifUrlPart/200.gif';
    ref.read(userDataAuthProvider).whenData((value) =>
        chatRepostry.sendGIFMessage(
            context: context,
            gifUrl: newGifUrl,
            recieverUserId: recverUserId,
            senderUser: value!,
            messageReply: messageReply));
    ref.read(messageReplyProvider.notifier).update((state) => null);
  }

  Stream<List<ChatContact>> chatContact() {
    return chatRepostry.getChatContact();
  }

  Stream<List<MessageModel>> chatStream(String reciverUserId) {
    return chatRepostry.getChatStream(reciverUserId);
  }

  void setChatMessageSeen(
      BuildContext context, String recverUserId, String messageId) {
    chatRepostry.setChatMessageSeen(context, recverUserId, messageId);
  }
}
