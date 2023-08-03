part of "../../../utils/import/app_import.dart";

class LandingScreen extends StatelessWidget {
  static const String nameRoute = "LandingScreen";
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          // * Space
          Container(
            height: AppDime.xlg.h,
          ),
          // * Welcome Text
          const Text(
            "Welcome To WhatsApp",
            style: TextStyle(fontSize: 33, fontWeight: FontWeight.w600),
          ),
          // * Space
          AppDime.xxl.verticalSpace,
          // * Image
          Image.asset(
            AppImages.landingScreenImg,
            height: 340,
            width: 340,
            color: AppColors.tabColor,
          ),
          // * Space
          AppDime.xxxi.verticalSpace,
          // * Accept The Terms Text
          Padding(
            padding: EdgeInsets.all(AppDime.lg.r),
            child: Text(
              'Read our Privacy Policy. Tap "Agree and continue" to accept the Terms of Service.',
              style: TextStyle(color: AppColors.bgGrey),
              textAlign: TextAlign.center,
            ),
          ),
          // * Bottn
          SizedBox(
              width: AppDime.xxxi.w * 2,
              child: CstomBtn(
                  onPressed: () {
                    AppRoute.go(context, LogInScreens.nameRoute);
                  },
                  title: "AGREE AND CONTINUE"))
        ],
      )),
    );
  }
}
