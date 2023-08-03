part of '../../../utils/import/app_import.dart';

class VideoPlyerItem extends StatefulWidget {
  const VideoPlyerItem({
    Key? key,
    required this.videoUrl,
  }) : super(key: key);
  final Uri videoUrl;
  @override
  State<VideoPlyerItem> createState() => _VideoPlyerItemState();
}

class _VideoPlyerItemState extends State<VideoPlyerItem> {
  late VideoPlayerController videoPleyerController;
  @override
  void initState() {
    super.initState();
    videoPleyerController = VideoPlayerController.networkUrl(widget.videoUrl)
      ..initialize().then(
        (value) {
          videoPleyerController.setVolume(1);
        },
      );
  }

  @override
  void dispose() {
    videoPleyerController.dispose();
    super.dispose();
  }

  bool isPlay = false;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(children: [
        VideoPlayer(videoPleyerController),
        Align(
            alignment: Alignment.center,
            child: IconButton(
              onPressed: () {
                if (isPlay) {
                  videoPleyerController.pause();
                } else {
                  videoPleyerController.play();
                }
                setState(() {
                  isPlay = !isPlay;
                });
              },
              icon: Icon(isPlay ? Icons.pause_circle : Icons.play_circle),
              iconSize: 50,
            ))
      ]),
    );
  }
}
