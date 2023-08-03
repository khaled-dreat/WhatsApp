// ignore_for_file: public_member_api_docs, sort_constructors_first
part of "../../../utils/import/app_import.dart";

final selectContatntsRepositoryProvider = Provider(
    (ref) => SelectContactRepository(firestore: FirebaseFirestore.instance));

class SelectContactRepository {
  final FirebaseFirestore firestore;
  SelectContactRepository({
    required this.firestore,
  });
  Future<List<Contact>> getContacts() async {
    List<Contact> contact = [];
    try {
      if (await FlutterContacts.requestPermission()) {
        contact = await FlutterContacts.getContacts(withProperties: true);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return contact;
  }

  void selectContant(Contact selectedContant, BuildContext context) async {
    try {
      var userCollection = await firestore.collection('user').get();
      bool isFound = false;
      for (var document in userCollection.docs) {
        var userData = UserModel.fromMap(document.data());
        String selectedPhoneNum = selectedContant.phones[0].number
            .replaceAll('-', '')
            .replaceAll(' ', '');
        if (selectedPhoneNum == userData.phoneNumber) {
          isFound = true;

          AppRoute.goMaterial(
              context,
              MobileChatScreen(
                arguments: {'name': userData.name, 'uid': userData.uid},
              ));
        }
        if (!isFound) {
          //print(userData.name);
          //print(selectedPhoneNum);
          showSnackBar(
              context: context, msg: "This number does not exist on this app");
        }
      }
    } catch (e) {
      showSnackBar(context: context, msg: e.toString());
    }
  }
}
