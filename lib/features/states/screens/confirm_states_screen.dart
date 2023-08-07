part of "../../../utils/import/app_import.dart";

class ConfirmStatesScreen extends ConsumerWidget {
  static const String nameRoute = 'ConfirmStatesScreen';
  final File file;
  const ConfirmStatesScreen(this.file, {super.key});

  void addSttus(WidgetRef ref, BuildContext context) {
    ref.read(statusControllerProvidet).addStatus(file, context);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
          child: AspectRatio(
        aspectRatio: 9 / 16,
        child: Image.file(file),
      )),
      floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.tabColor,
          onPressed: () => addSttus(ref, context),
          child: const Icon(
            Icons.done,
            color: Colors.white,
          )),
    );
  }
}
