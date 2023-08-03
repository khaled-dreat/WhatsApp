// ignore_for_file: public_member_api_docs, sort_constructors_first
part of "../../../utils/import/app_import.dart";

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
      auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance),
);

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  AuthRepository({
    required this.auth,
    required this.firestore,
  });
  Future<UserModel?> getCurrentUserData() async {
    var userData =
        await firestore.collection('user').doc(auth.currentUser?.uid).get();
    UserModel? user;
    if (userData.data() != null) {
      user = UserModel.fromMap(userData.data()!);
    }
    return user;
  }

  void singInWithPhon(BuildContext context, String phoneNum) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNum,
        verificationCompleted: (phoneAuthCredential) async {
          await auth.signInWithCredential(phoneAuthCredential);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        verificationFailed: (FirebaseAuthException error) {
          throw Exception(error.message);
        },
        codeSent: (String verificationId, int? forceResendingToken) async {
          AppRoute.goMaterial(
              context, OTPScreen(verificationId: verificationId));
        },
      );
    } on FirebaseAuthException catch (error) {
      //   AppSnackBar.snackBarError(context, msg: );
      showSnackBar(context: context, msg: error.message!);
    }
  }

  void verifyOTP(
      {required BuildContext context,
      required String verificationID,
      required String userOTP}) async {
    try {
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: verificationID, smsCode: userOTP);
      await auth.signInWithCredential(phoneAuthCredential);
      AppRoute.goReplaceRemove(context, UserInformtionScreen.nameRoute);
    } on FirebaseAuthException catch (error) {
      //   AppSnackBar.snackBarError(context, msg: );
      showSnackBar(context: context, msg: error.message!);
    }
  }

  void saveUserDataToFirebase(
      {required String name,
      required File? profilePic,
      required ProviderRef ref,
      required BuildContext context}) async {
    try {
      String uId = auth.currentUser!.uid;
      String photoUrl = "assets/img/Defult_Img_User.jpeg";
      if (profilePic != null) {
        photoUrl = await ref
            .read(commonFirebaseStorageRepositoryprovider)
            .storageFileTOFirebase('profilePic/$uId', profilePic);
      }
      var user = UserModel(
          name: name,
          uid: uId,
          profilePic: photoUrl,
          phoneNumber: auth.currentUser!.phoneNumber!,
          isOnline: true,
          groupId: []);
      firestore.collection("user").doc(uId).set(user.toMap());
      AppRoute.goReplace(context, MobileLayoutScreen.nameRoute);
    } catch (e) {
      showSnackBar(context: context, msg: e.toString());
    }
  }

  Stream<UserModel> userData(String userId) {
    return firestore.collection('user').doc(userId).snapshots().map(
          (event) => UserModel.fromMap(
            event.data()!,
          ),
        );
  }

  void setUserState(bool isOnline) async {
    await firestore
        .collection('user')
        .doc(auth.currentUser!.uid)
        .update({'isOnline': isOnline});
  }
}
