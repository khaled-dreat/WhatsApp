part of '../utils/import/app_import.dart';

class MyWhatsApp extends ConsumerWidget {
  const MyWhatsApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (context, child) => MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Whatsapp UI',
              theme: ThemeData.dark().copyWith(
                  scaffoldBackgroundColor: AppColors.backgroundColor,
                  appBarTheme: AppBarTheme(color: AppColors.appBarColor)),
              routes: AppRoute.routes,
              home: ref.watch(userDataAuthProvider).when(
                    data: (user) {
                      if (user == null) {
                        return LandingScreen();
                      }
                      return MobileLayoutScreen();
                    },
                    error: (error, stackTrace) {
                      return;
                    },
                    loading: () => Loader(),
                  ),
            ));
  }
}
