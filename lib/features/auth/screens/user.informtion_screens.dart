part of '../../../utils/import/app_import.dart';

class UserInformtionScreen extends ConsumerStatefulWidget {
  static const nameRoute = "UserInformtionScreen";
  const UserInformtionScreen({super.key});

  @override
  ConsumerState<UserInformtionScreen> createState() =>
      _UserInformtionScreenState();
}

class _UserInformtionScreenState extends ConsumerState<UserInformtionScreen> {
  final TextEditingController nameController = TextEditingController();
  File? image;
  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  void selectImage() async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

  void storeUserData() async {
    String name = nameController.text.trim();
    if (name.isNotEmpty) {
      ref
          .read(authControllerProvider)
          .saveUserDataToFirebase(context, name, image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
              child: Column(
        children: [
          Stack(
            children: [
              image == null
                  ? CircleAvatar(
                      radius: AppDime.xxl_9.r,
                      backgroundImage: const NetworkImage(
                          "https://i.pinimg.com/236x/e5/6b/02/e56b02089275a812ebbf975f47b8f768.jpg"),
                    )
                  : CircleAvatar(
                      radius: AppDime.xxl_9.r,
                      backgroundImage: FileImage(image!),
                    ),
              Positioned(
                  bottom: -10,
                  left: 140,
                  child: IconButton(
                      iconSize: 30,
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo)))
            ],
          ),
          Row(
            children: [
              Container(
                width: AppDime.xxxi * 2.w,
                padding: EdgeInsets.all(AppDime.lg.r),
                child: TextField(
                    controller: nameController,
                    decoration:
                        const InputDecoration(hintText: "Enter your name")),
              ),
              IconButton(onPressed: storeUserData, icon: const Icon(Icons.done))
            ],
          )
        ],
      ))),
    );
  }
}
