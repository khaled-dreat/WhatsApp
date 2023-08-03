part of '../../../utils/import/app_import.dart';

class DisplayTextImageGif extends StatelessWidget {
  const DisplayTextImageGif({
    Key? key,
    required this.msg,
    required this.type,
  }) : super(key: key);
  final String msg;
  final MessageEnum type;

  @override
  Widget build(BuildContext context) {
    bool isPlaying = false;
    final AudioPlayer audioplayers = AudioPlayer();
    return type == MessageEnum.text
        ? Text(msg,
            style: const TextStyle(
              fontSize: 16,
            ))
        : type == MessageEnum.video
            ? VideoPlyerItem(videoUrl: Uri.parse(msg))
            : type == MessageEnum.gif
                ? CachedNetworkImage(
                    imageUrl: msg,
                  )
                : type == MessageEnum.audio
                    ? StatefulBuilder(builder: (context, setState) {
                        return IconButton(
                            onPressed: () async {
                              if (isPlaying) {
                                await audioplayers.pause();
                                setState(
                                  () {
                                    isPlaying = false;
                                  },
                                );
                              } else {
                                await audioplayers.play(UrlSource(msg));
                                setState(
                                  () {
                                    isPlaying = true;
                                  },
                                );
                              }
                            },
                            icon: Icon(isPlaying
                                ? Icons.pause_circle
                                : Icons.play_circle));
                      })
                    : CachedNetworkImage(
                        imageUrl: msg,
                      );
  }
}
