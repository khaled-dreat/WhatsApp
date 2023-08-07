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
      width: 350,
      decoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      padding: const EdgeInsets.all(8),
      child: Column(children: [
        Row(
          children: [
            Expanded(
                child: Text(
              msgReply!.isMe ? 'Me' : 'Opposite',
              style: const TextStyle(fontWeight: FontWeight.bold),
            )),
            InkWell(
              onTap: () => cancelReply(ref),
              child: const Icon(
                Icons.close,
                size: 16,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        DisplayTextImageGif(msg: msgReply.msg, type: msgReply.messageEnum)
      ]),
    );
  }
}
