part of "../../../utils/import/app_import.dart";

class MyMessageCard extends StatelessWidget {
  final String message;
  final String date;
  final MessageEnum type;
  final VoidCallback onLiftSwipe;
  final String replyedMesaage;
  final String userName;
  final MessageEnum replyMessagetype;
  const MyMessageCard({
    Key? key,
    required this.message,
    required this.date,
    required this.type,
    required this.onLiftSwipe,
    required this.replyedMesaage,
    required this.userName,
    required this.replyMessagetype,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isRepling = replyedMesaage.isNotEmpty;
    return SwipeTo(
      onLeftSwipe: onLiftSwipe,
      child: Align(
        alignment: Alignment.centerRight,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 45,
          ),
          child: Card(
            elevation: 1,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: AppColors.messageColor,
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Stack(
              children: [
                Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 30,
                      top: 5,
                      bottom: 20,
                    ),
                    child: Padding(
                      padding: type == MessageEnum.text
                          ? const EdgeInsets.only(
                              left: 10, right: 30, top: 5, bottom: 20)
                          : const EdgeInsets.only(
                              left: 5, right: 5, top: 5, bottom: 25),
                      child: Column(
                        children: [
                          if (isRepling) ...[
                            Text(
                              userName,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: AppColors.backgroundColor
                                      .withOpacity(0.5),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5))),
                              child: DisplayTextImageGif(
                                  msg: replyedMesaage, type: replyMessagetype),
                            ),
                            const SizedBox(
                              height: 8,
                            )
                          ],
                          DisplayTextImageGif(msg: message, type: type),
                        ],
                      ),
                    )),
                Positioned(
                  bottom: 4,
                  right: 10,
                  child: Row(
                    children: [
                      Text(
                        date,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white60,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(
                        Icons.done_all,
                        size: 20,
                        color: Colors.white60,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
