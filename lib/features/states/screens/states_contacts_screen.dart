part of "../../../utils/import/app_import.dart";

class StatesContactsScreen extends ConsumerWidget {
  const StatesContactsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<List<ModelStatus>>(
      future: ref.read(statusControllerProvidet).getStatus(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        }
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            var statusData = snapshot.data![index];
            // dev.log(snapshot.data![index].toString());
            return Column(
              children: [
                InkWell(
                  onTap: () async {
                    AppRoute.goMaterial(
                        context, StutesScreen(stutes: statusData));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ListTile(
                      title: Text(
                        statusData.username,
                      ),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          statusData.profilePic,
                        ),
                        radius: 30,
                      ),
                    ),
                  ),
                ),
                Divider(color: AppColors.dividerColor, indent: 85),
              ],
            );
          },
        );
      },
    );
  }
}
//StatesContactsScreen