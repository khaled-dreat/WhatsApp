part of '../../../utils/import/app_import.dart';

class ChatList extends ConsumerStatefulWidget {
  const ChatList(this.reciverUserId, {Key? key}) : super(key: key);
  final String reciverUserId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatListState();
}

class _ChatListState extends ConsumerState<ChatList> {
  final ScrollController messageController = ScrollController();
  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  void onMessageSwipe(String msg, bool isMe, MessageEnum messageEnum) {
    ref.read(messageReplyProvider.notifier).update((state) =>
        MessageReply(msg: msg, isMe: isMe, messageEnum: messageEnum));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<MessageModel>>(
        stream:
            ref.read(chatControlerProvider).chatStream(widget.reciverUserId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }
          SchedulerBinding.instance.addPostFrameCallback((_) {
            messageController
                .jumpTo(messageController.position.maxScrollExtent);
          });
          return ListView.builder(
            controller: messageController,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final messageData = snapshot.data![index];
              var timeSend = DateFormat.Hm().format(messageData.timeSend);
              if (messageData.senderId ==
                  FirebaseAuth.instance.currentUser!.uid) {
                return MyMessageCard(
                  message: messageData.text,
                  date: timeSend,
                  type: messageData.type,
                  onLiftSwipe: () =>
                      onMessageSwipe(messageData.text, true, messageData.type),
                  replyedMesaage: messageData.repliedMessage,
                  userName: messageData.repliedTo,
                  replyMessagetype: messageData.repliedMessageType,
                );
              }
              return SenderMessageCard(
                message: messageData.text,
                date: timeSend,
                type: messageData.type,
                onRightSwipe: () =>
                    onMessageSwipe(messageData.text, false, messageData.type),
                replyMessagetype: messageData.repliedMessageType,
                replyedMesaage: messageData.repliedMessage,
                userName: messageData.repliedTo,
              );
            },
          );
        });
  }
}
