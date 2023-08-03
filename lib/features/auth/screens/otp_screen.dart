part of '../../../utils/import/app_import.dart';

class OTPScreen extends ConsumerWidget {
  static const String nameRoute = "OTPScreen";
  const OTPScreen({
    Key? key,
    required this.verificationId,
  }) : super(key: key);
  final String verificationId;
  void veriftOYP(WidgetRef ref, BuildContext context, String userOTP) {
    ref
        .read(authControllerProvider)
        .verifyOTP(context, verificationId, userOTP);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Verifying your number"),
          elevation: 0,
          centerTitle: true,
          backgroundColor: AppColors.backgroundColor),
      body: Center(
        child: Column(children: [
          AppDime.lg.verticalSpace,
          const Text("We have sent an SMS with a code"),
          SizedBox(
            width: AppDime.xxl_1 * 1.7.w,
            child: TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                if (value.length == 6) {
                  veriftOYP(ref, context, value.trim());
                }
              },
              decoration: const InputDecoration(
                  hintText: "- - - - - -", hintStyle: TextStyle(fontSize: 30)),
            ),
          )
        ]),
      ),
    );
  }
}
