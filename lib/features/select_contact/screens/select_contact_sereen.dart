part of "../../../utils/import/app_import.dart";

class SelectContactScreen extends ConsumerWidget {
  static const String nameRoute = "SelectContactScreen";
  const SelectContactScreen({super.key});
  void selectContact(
      WidgetRef ref, Contact selectContact, BuildContext context) {
    ref
        .read(selectContacRepositryProvider)
        .selectContact(context, selectContact);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Contact"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
      ),
      body: ref.watch(getContactProvider).when(
          data: (contactsList) => ListView.builder(
                itemCount: contactsList.length,
                itemBuilder: (context, index) {
                  final contact = contactsList[index];
                  return InkWell(
                    onTap: () => selectContact(ref, contact, context),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ListTile(
                        title: Text(
                          contact.displayName,
                          style: const TextStyle(fontSize: 18),
                        ),
                        leading: contact.photo == null
                            ? null
                            : CircleAvatar(
                                backgroundImage: MemoryImage(contact.photo!),
                                radius: 30),
                      ),
                    ),
                  );
                },
              ),
          error: (error, stackTrace) {
            return;
          },
          loading: () => const Loader()),
    );
  }
}
