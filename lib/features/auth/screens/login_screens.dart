part of '../../../utils/import/app_import.dart';

class LogInScreens extends ConsumerStatefulWidget {
  static const String nameRoute = "LogInScreens";
  const LogInScreens({super.key});

  @override
  ConsumerState<LogInScreens> createState() => _LogInScreensState();
}

class _LogInScreensState extends ConsumerState<LogInScreens> {
  final phoneController = TextEditingController();
  Country? country;
  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  void pickCountry() {
    showCountryPicker(
      context: context,
      onSelect: (Country _country) {
        setState(() {
          country = _country;
        });
      },
    );
  }

  void sendPhoneNum() {
    String phoneNumber = phoneController.text.trim();
    if (country != null && phoneNumber.isNotEmpty) {
      ref
          .read(authControllerProvider)
          .singInWithPhone(context, "+${country!.phoneCode}$phoneNumber");
    } else {
      showSnackBar(context: context, msg: "Fill out all the fields");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Enter Your Phone Number"),
          elevation: 0,
          backgroundColor: AppColors.backgroundColor),
      body: Padding(
        padding: EdgeInsets.all(AppDime.lg.r),
        child: Column(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("WhatsApp will need to verify your phone number."),
              Container(height: 10.h),
              TextButton(
                  onPressed: pickCountry, child: const Text("Pick Country")),
              AppDime.lg.h.verticalSpace,
              Row(
                children: [
                  if (country != null) Text("+${country!.phoneCode}"),
                  AppDime.md.w.horizontalSpace,
                  SizedBox(
                    width: AppDime.xxxi * 2.w,
                    child: TextField(
                      controller: phoneController,
                      decoration:
                          const InputDecoration(hintText: "phone number"),
                    ),
                  )
                ],
              ),
              // * Space
              (AppDime.xxxi * 3.2).verticalSpace,
              // * Btn
              SizedBox(
                width: AppDime.xxl_9.w,
                child: CstomBtn(onPressed: sendPhoneNum, title: "NEXT"),
              )
            ]),
      ),
    );
  }
}
