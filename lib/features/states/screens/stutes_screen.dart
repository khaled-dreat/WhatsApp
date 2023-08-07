part of "../../../utils/import/app_import.dart";

class StutesScreen extends StatefulWidget {
  static const String nameRoute = "StutesScreen";
  const StutesScreen({super.key, required this.stutes});
  final ModelStatus stutes;
  @override
  State<StutesScreen> createState() => _StutesScreenState();
}

class _StutesScreenState extends State<StutesScreen> {
  StoryController controller = StoryController();
  List<StoryItem> storyItem = [];
  @override
  void initState() {
    super.initState();
    initStoryPageItem();
  }

  void initStoryPageItem() {
    for (int i = 0; i < widget.stutes.photoUrl.length; i++) {
      storyItem.add(StoryItem.pageImage(
          controller: controller, url: widget.stutes.photoUrl[i]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: storyItem.isEmpty
          ? const Loader()
          : StoryView(
              storyItems: storyItem,
              controller: controller,
              onVerticalSwipeComplete: (direction) {
                if (direction == Direction.down) {
                  Navigator.pop(context);
                }
              }),
    );
  }
}
