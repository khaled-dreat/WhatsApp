part of '../../../utils/import/app_import.dart';

final statusRepostryProvidet = Provider((ref) => StatesRepostry(
    fireStore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
    ref: ref));

class StatesRepostry {
  final FirebaseFirestore fireStore;
  final FirebaseAuth auth;
  final ProviderRef ref;
  StatesRepostry({
    required this.fireStore,
    required this.auth,
    required this.ref,
  });
  void upLoadStates({
    required String userName,
    required String profilePic,
    required String phonNumber,
    required File statesImage,
    required BuildContext context,
  }) async {
    try {
      var statesId = const Uuid().v1();
      String uId = auth.currentUser!.uid;
      String imageUrl = await ref
          .read(commonFirebaseStorageRepositoryprovider)
          .storageFileTOFirebase('/status/$statesId$uId', statesImage);
      List<Contact> contact = [];
      if (await FlutterContacts.requestPermission()) {
        contact = await FlutterContacts.getContacts(withProperties: true);
      }
      List<String> uidwhocanSee = [];
      for (int i = 0; i < contact.length; i++) {
        // تقوم بجلب المستخدمين من فير بيس الذين ارقامهم موجودة لديك على الهاتف
        var userDataFirebase = await fireStore
            .collection('user')
            .where('phoneNumber',
                isEqualTo: contact[i]
                    .phones[0]
                    .number
                    .replaceAll('-', '')
                    .replaceAll(' ', ''))
            .get();
        //* للتأكد من انه المعلومات في هذه الدورة غير فارغة
        if (userDataFirebase.docs.isNotEmpty) {
          var userData = UserModel.fromMap(userDataFirebase.docs[0].data());
          uidwhocanSee.add(userData.uid);
        }
        List<String> statesImeagUrls = [];
        var statusSnapshot = await fireStore
            .collection('status')
            .where('uid', isEqualTo: auth.currentUser!.uid)
            .get();
        if (statusSnapshot.docs.isNotEmpty) {
          ModelStatus status =
              ModelStatus.fromMap(statusSnapshot.docs[0].data());
          statesImeagUrls = status.photoUrl;
          statesImeagUrls.add(imageUrl);
          await fireStore
              .collection('status')
              .doc(statusSnapshot.docs[0].id)
              .update({'photourl': statesImeagUrls});
          return;
        } else {
          statesImeagUrls = [imageUrl];
        }
        ModelStatus status = ModelStatus(
            uid: uId,
            username: userName,
            phoneNumber: phonNumber,
            photoUrl: statesImeagUrls,
            createdAt: DateTime.now(),
            profilePic: profilePic,
            statusId: statesId,
            whoCanSee: uidwhocanSee);
        await fireStore.collection('status').doc(statesId).set(status.toMap());
      }
    } catch (e) {
      showSnackBar(context: context, msg: e.toString());
    }
  }

  Future<List<ModelStatus>> getStatus(BuildContext context) async {
    List<ModelStatus> statusData = [];
    try {
      List<Contact> contact = [];
      if (await FlutterContacts.requestPermission()) {
        contact = await FlutterContacts.getContacts(withProperties: true);
      }
      for (int i = 0; i < contact.length; i++) {
        dev.log(contact.length.toString());
        dev.log(contact[0].phones.length.toString());
        var statusSnapshot = await fireStore
            .collection('status')
            .where('phoneNumber',
                isEqualTo: contact[i]
                    .phones[0]
                    .number
                    .replaceAll('-', '')
                    .replaceAll(' ', ''))
            .where('createdAt',
                isGreaterThan: DateTime.now()
                    .subtract(const Duration(hours: 24))
                    .millisecondsSinceEpoch)
            .get();
        for (var tempData in statusSnapshot.docs) {
          ModelStatus tempStatus = ModelStatus.fromMap(tempData.data());
          if (tempStatus.whoCanSee.contains(auth.currentUser!.uid)) {
            statusData.add(tempStatus);
          }
        }
      }
    } catch (e) {
      if (kDebugMode) print(e);
      showSnackBar(context: context, msg: e.toString());
    }
    return statusData;
  }
}
