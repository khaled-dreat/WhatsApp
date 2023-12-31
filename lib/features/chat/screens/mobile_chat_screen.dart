// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../../../utils/import/app_import.dart';

class MobileChatScreen extends ConsumerWidget {
  static const String nameRoute = "MobileChatScreen";
  final bool? isGroupChat;
  final Map<String, dynamic>? arguments;
  const MobileChatScreen({
    Key? key,
    this.arguments,
    this.isGroupChat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        title: isGroupChat!
            ? Text(arguments?['name'])
            : StreamBuilder<UserModel>(
                stream: ref
                    .read(authControllerProvider)
                    .userDataById(arguments?['uid']),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Loader();
                  }
                  return Column(
                    children: [
                      Text(arguments?['name']),
                      Text(
                        snapshot.data!.isOnline ? 'online' : 'offline',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  );
                }),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.video_call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ChatList(arguments?['uid'], isGroupChat),
          ),
          BottomChatField(arguments?['uid'], isGroupChat),
        ],
      ),
    );
  }
}
