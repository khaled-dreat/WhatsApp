part of '../../utils/import/app_import.dart';

class CstomBtn extends StatelessWidget {
  const CstomBtn({super.key, required this.onPressed, required this.title});
  final VoidCallback onPressed;
  final String title;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.tabColor,
            minimumSize: const Size(double.infinity, 50)),
        child: Text(
          title,
          style: TextStyle(color: AppColors.bgBlack),
        ));
  }
}
