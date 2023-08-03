part of '../../utils/import/app_import.dart';

class ErrorText extends StatelessWidget {
  const ErrorText({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
      ),
    );
  }
}
