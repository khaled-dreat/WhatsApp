part of '../../utils/import/app_import.dart';

void showSnackBar({required BuildContext context, required String msg}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
}
