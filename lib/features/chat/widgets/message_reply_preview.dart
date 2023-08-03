part of "../../../utils/import/app_import.dart";

class MessageReplyPreview extends ConsumerWidget {
  const MessageReplyPreview({super.key});
  void cancelReply(WidgetRef ref) {
    ref.read(messageReplyProvider.notifier).update((state) => null);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final msgReply = ref.watch(messageReplyProvider);
    return Container(
      width: 300,
      padding: const EdgeInsets.all(8),
      child: Column(children: [
        Row(
          children: [
            Expanded(
                child: Text(
              msgReply!.isMe ? 'Me' : 'Opposite',
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
            InkWell(
              onTap: () => cancelReply(ref),
              child: Icon(
                Icons.close,
                size: 16,
              ),
            )
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          msgReply.msg,
        )
      ]),
    );
  }
}
