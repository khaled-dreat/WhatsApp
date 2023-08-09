part of "../../../utils/import/app_import.dart";

final groupControllerProvider = Provider((ref) {
  final groupRepostry = ref.read(groupRepostryProvider);

  return GroupController(groupRepostry: groupRepostry, ref: ref);
});

class GroupController {
  final GroupRepostry groupRepostry;
  final ProviderRef ref;
  GroupController({
    required this.groupRepostry,
    required this.ref,
  });
  void creatGroup(BuildContext context, String name, File profilePic,
      List<Contact> selectedContact) {
    groupRepostry.creatGroup(context, name, profilePic, selectedContact);
  }
}
