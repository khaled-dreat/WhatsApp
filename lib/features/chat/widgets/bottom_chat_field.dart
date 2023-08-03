part of '../../../utils/import/app_import.dart';

final chatControlerProvider = Provider(
  (ref) {
    final chatRepostry = ref.watch(chatrepositoryProvider);
    return ChatController(chatRepostry: chatRepostry, ref: ref);
  },
);

class BottomChatField extends ConsumerStatefulWidget {
  const BottomChatField(this.recieverUserId, {super.key});
  final String recieverUserId;
  @override
  ConsumerState<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends ConsumerState<BottomChatField> {
  bool isSowwSendButton = false;
  bool isSowwEmojeContaner = false;
  FocusNode focusNode = FocusNode();
  FlutterSoundRecorder? _soundRecorder;
  bool isRecordingInit = false;
  bool isRecording = false;

  final TextEditingController _messageController = TextEditingController();

  void sendTextmessage() async {
    if (isSowwSendButton) {
      ref.read(chatControlerProvider).sendTextMessage(
          context, _messageController.text.trim(), widget.recieverUserId);
      setState(() {
        _messageController.text = "";
      });
    } else {
      var timDir = await getTemporaryDirectory();
      var path = '${timDir.path}/flutter_sound.aac';
      if (!isRecordingInit) {
        return;
      }
      if (isRecording) {
        await _soundRecorder!.stopRecorder();
        sendFileMessage(File(path), MessageEnum.audio);
      } else {
        await _soundRecorder!.startRecorder(toFile: path);
      }
      setState(() {
        isRecording = !isRecording;
      });
    }
  }

  void showEmojeContaner() {
    setState(() {
      isSowwEmojeContaner = true;
    });
  }

  void hideEmojeContaner() {
    setState(() {
      isSowwEmojeContaner = false;
    });
  }

  void showKetbord() => focusNode.requestFocus();
  void hideKetbord() => focusNode.unfocus();
  void toggleEmojeKeybordContaner() {
    if (isSowwEmojeContaner) {
      showKetbord();
      hideEmojeContaner();
    } else {
      hideKetbord();
      showEmojeContaner();
    }
  }

  void sendFileMessage(File file, MessageEnum messageEnum) {
    dev.log("sendFileMessage_UI");
    ref
        .read(chatControlerProvider)
        .sendFileMessage(context, widget.recieverUserId, messageEnum, file);
  }

  void selectImage() async {
    dev.log("sendFileMessage_selectImage");

    File? image = await pickImageFromGallery(context);
    if (image != null) {
      sendFileMessage(image, MessageEnum.image);
    }
  }

  void selectvideo() async {
    File? video = await pickVideoFromGallery(context);
    if (video != null) {
      sendFileMessage(video, MessageEnum.video);
    }
  }

  void selectGIF() async {
    final gif = await pickGIF(context);
    if (gif != null) {
      ref
          .read(chatControlerProvider)
          .sendGIFMessage(context, widget.recieverUserId, gif.url);
    }
  }

  void openAudeo() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException("Mic Permission not allowed!");
    }
    await _soundRecorder!.openRecorder();
    isRecordingInit = true;
  }
/*
void openAudio() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Mic permission not allowed!');
    }
    await _soundRecorder!.openRecorder();
    isRecorderInit = true;
  }*/

  @override
  void dispose() {
    _messageController.dispose();
    _soundRecorder!.closeRecorder();
    isRecordingInit = false;

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _soundRecorder = FlutterSoundRecorder();
    openAudeo();
  }

  @override
  Widget build(BuildContext context) {
    final messageReply = ref.watch(messageReplyProvider);
    final isShowMessageReply = messageReply != null;
    return Column(
      children: [
        isShowMessageReply ? const MessageReplyPreview() : const SizedBox(),
        Row(
          children: [
            Expanded(
              child: TextField(
                focusNode: focusNode,
                controller: _messageController,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    setState(() {
                      isSowwSendButton = true;
                    });
                  } else {
                    setState(() {
                      isSowwSendButton = false;
                    });
                  }
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.mobileChatBoxColor,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: toggleEmojeKeybordContaner,
                            icon: const Icon(Icons.emoji_emotions),
                            color: Colors.grey,
                          ),
                          IconButton(
                            onPressed: selectGIF,
                            icon: const Icon(Icons.gif),
                            color: Colors.grey,
                          )
                        ],
                      ),
                    ),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SizedBox(
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.camera_alt,
                            ),
                            onPressed: () async {
                              selectImage();
                              dev.log("sendFileMessage_IconBotton");
                            },
                            color: Colors.grey,
                          ),
                          IconButton(
                            onPressed: selectvideo,
                            icon: const Icon(Icons.attach_file),
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                  hintText: 'Type a message!',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(10),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8, left: 2, right: 2),
              child: CircleAvatar(
                backgroundColor: Color(0xFF128C7E),
                radius: 25,
                child: GestureDetector(
                  onTap: sendTextmessage,
                  child: Icon(
                    isSowwSendButton
                        ? Icons.send
                        : isRecording
                            ? Icons.close
                            : Icons.mic,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        isSowwEmojeContaner
            ? SizedBox(
                height: 310,
                child: EmojiPicker(
                  onEmojiSelected: (category, emoji) {
                    setState(() {
                      _messageController.text =
                          _messageController.text + emoji.emoji;
                    });
                    if (!isSowwSendButton) {
                      setState(() {
                        isSowwSendButton = true;
                      });
                    }
                  },
                ),
              )
            : SizedBox()
      ],
    );
  }
}
