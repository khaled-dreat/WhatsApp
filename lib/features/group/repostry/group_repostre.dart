part of "../../../utils/import/app_import.dart";

final groupRepostryProvider = Provider((ref) => GroupRepostry(
    auth: FirebaseAuth.instance,
    fireStore: FirebaseFirestore.instance,
    ref: ref));

class GroupRepostry {
  final FirebaseAuth auth;
  final FirebaseFirestore fireStore;
  final ProviderRef ref;
  GroupRepostry({
    required this.auth,
    required this.fireStore,
    required this.ref,
  });
  void creatGroup(BuildContext context, String name, File profilPic,
      List<Contact> selectedContact) async {
    try {
      List<String> uids = [];
      for (int i = 0; i < selectedContact.length; i++) {
        var userColection = await fireStore
            .collection('user')
            .where('phoneNumber',
                isEqualTo: selectedContact[i]
                    .phones[0]
                    .number
                    .replaceAll('-', '')
                    .replaceAll(' ', ''))
            .get();
        if (userColection.docs.isNotEmpty && userColection.docs[0].exists) {
          uids.add(userColection.docs[0].data()['uid']);
        }
      }
      var groupId = Uuid().v1();
      String profileUrl = await ref
          .read(commonFirebaseStorageRepositoryprovider)
          .storageFileTOFirebase('group/$groupId', profilPic);
      ModelGroup group = ModelGroup(
          name: name,
          senderId: auth.currentUser!.uid,
          groupId: groupId,
          lastMessage: '',
          timeSent: DateTime.now(),
          groupPic: profileUrl,
          membersUid: [auth.currentUser!.uid, ...uids]);
      await fireStore.collection('group').doc(groupId).set(group.toMap());
    } catch (e) {
      showSnackBar(context: context, msg: e.toString());
    }
  }
}
