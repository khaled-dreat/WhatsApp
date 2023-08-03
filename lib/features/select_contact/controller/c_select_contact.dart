// ignore_for_file: public_member_api_docs, sort_constructors_first
part of "../../../utils/import/app_import.dart";

final getContactProvider = FutureProvider(
  (ref) {
    final selectContactRepository =
        ref.watch(selectContatntsRepositoryProvider);
    return selectContactRepository.getContacts();
  },
);

final selectContacRepositryProvider = Provider(
  (ref) {
    final selectContacRepositry = ref.watch(selectContatntsRepositoryProvider);
    return SelectContactController(
        ref: ref, selectContacRepositry: selectContacRepositry);
  },
);

class SelectContactController {
  final ProviderRef ref;
  final SelectContactRepository selectContacRepositry;
  SelectContactController({
    required this.ref,
    required this.selectContacRepositry,
  });
  void selectContact(BuildContext context, Contact selectedContant) {
    selectContacRepositry.selectContant(selectedContant, context);
  }
}
