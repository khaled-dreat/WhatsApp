part of '../import/app_import.dart';

class AppRoute {
  static Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    LandingScreen.nameRoute: (context) => const LandingScreen(),
    LogInScreens.nameRoute: (context) => const LogInScreens(),
    UserInformtionScreen.nameRoute: (context) => const UserInformtionScreen(),
    MobileLayoutScreen.nameRoute: (context) => const MobileLayoutScreen(),
    SelectContactScreen.nameRoute: (context) => const SelectContactScreen(),
    MobileChatScreen.nameRoute: (context) => const MobileChatScreen(),
    CreatGroupScreen.nameRoute: (context) => const CreatGroupScreen(),
    //OTPScreen.nameRoute: (context) => const OTPScreen(),
  };
  // * inti Route

  static String? initRoute = LogInScreens.nameRoute;

  // * push Name
  static void go(BuildContext context, String nameRoute) =>
      Navigator.pushNamed(context, nameRoute);
  // * push Name Replace
  static void goReplace(BuildContext context, String nameRoute) =>
      Navigator.pushReplacementNamed(context, nameRoute);
  // * push Name Replace
  static void goReplaceRemove(BuildContext context, String nameRoute) =>
      Navigator.pushNamedAndRemoveUntil(
        context,
        nameRoute,
        (route) => false,
      );

  // * push Name
  static void goMaterial(BuildContext context, Widget page) {
    MaterialPageRoute<Widget> route =
        MaterialPageRoute(builder: (context) => page);
    Navigator.push(context, route);
  }

  // * Error Page
  static MaterialPageRoute errorPage(String msg, BuildContext context) {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
          body: ErrorText(
        title: msg,
      )),
    );
  }
}
