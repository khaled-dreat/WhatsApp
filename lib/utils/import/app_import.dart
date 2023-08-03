import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:enough_giphy_flutter/enough_giphy_flutter.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:uuid/uuid.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:developer' as dev;

// ? ************************ WhatsApp App **************************
part '../../app_whatsapp/app_start.dart';

// ? ************************ Controller **************************
part '../../features/auth/controller/c_auth.dart';
part '../../features/select_contact/controller/c_select_contact.dart';
part '../../features/chat/controller/c_chat.dart';

// ? ************************ Model **************************
part '../../model/m_user.dart';
part '../../model/chat_contact.dart';
part '../../model/message.dart';
// ************************ Utils **************************
part '../route/app_route.dart';
part '../theme/app_color.dart';
part '../constant/app_images.dart';
part '../dime/app_dime.dart';
part '../../features/auth/repository/auth_repository.dart';
part "../../common/repositories/common_firebase_storage_repository.dart";
part "../../features/chat/repository/chat_repository.dart";
part '../../common/enum/message_enum.dart';
part "../../common/providers/message_reply_providers.dart";
// ************************ View **************************
part '../../features/chat/screens/mobile_chat_screen.dart';
part '../../screens/mobile_layout_screen.dart';
part '../../screens/web_layout_screen.dart';
part '../responsive_layout.dart';
part '../../features/landing/screen/landing_screen.dart';
part '../../common/widgets/cstom_btn.dart';
part "../../features/auth/screens/login_screens.dart";
part '../../features/auth/screens/user.informtion_screens.dart';
part '../../features/select_contact/repostry/select_contact_repostry.dart';
part '../../features/select_contact/screens/select_contact_sereen.dart';
part '../../features/chat/widgets/bottom_chat_field.dart';
// ************************ Widgets **************************
part '../../features/chat/widgets/chat_list.dart';
part '../../features/chat/widgets/contacts_list.dart';
part '../../features/chat/widgets/my_message_card.dart';
part '../../features/chat/widgets/sender_message_card.dart';
part '../../widgets/web_chat_appbar.dart';
part '../../widgets/web_profile_bar.dart';
part '../../widgets/web_search_bar.dart';
part '../../common/widgets/error_text.dart';
part '../../features/auth/screens/otp_screen.dart';
part "../../widgets/pick_image/pick_image.dart";
part '../../widgets/snackbar/snackbar.dart';
part '../../common/widgets/loader.dart';
part '../../features/chat/widgets/display_text_imege_gif.dart';
part "../../features/chat/widgets/video_plyer_item.dart";
part "../../features/chat/widgets/message_reply_preview.dart";
/************************************* */
