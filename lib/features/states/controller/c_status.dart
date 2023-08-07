// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../../../utils/import/app_import.dart';

final statusControllerProvidet = Provider(
  (ref) {
    final statusRepostry = ref.read(statusRepostryProvidet);
    return StatusController(statesRepostry: statusRepostry, ref: ref);
  },
);

class StatusController {
  final StatesRepostry statesRepostry;
  final ProviderRef ref;
  StatusController({
    required this.statesRepostry,
    required this.ref,
  });
  void addStatus(File file, BuildContext context) {
    ref.watch(userDataAuthProvider).whenData(
      (value) {
        statesRepostry.upLoadStates(
            userName: value!.name,
            profilePic: value.profilePic,
            phonNumber: value.phoneNumber,
            statesImage: file,
            context: context);
      },
    );
  }

  Future<List<ModelStatus>> getStatus(BuildContext context) async {
    List<ModelStatus> statuses = await statesRepostry.getStatus(context);
    return statuses;
  }
}
