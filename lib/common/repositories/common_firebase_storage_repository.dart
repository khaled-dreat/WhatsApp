// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../../utils/import/app_import.dart';

final commonFirebaseStorageRepositoryprovider = Provider((ref) =>
    CommonFirebaseStorageRepository(firebaseStorage: FirebaseStorage.instance));

class CommonFirebaseStorageRepository {
  final FirebaseStorage firebaseStorage;
  CommonFirebaseStorageRepository({
    required this.firebaseStorage,
  });
  Future<String> storageFileTOFirebase(String ref, File file) async {
    //* [.child(ref)] تشير الى المسار في firebase الذي سيتم حفظ الملف به
    UploadTask uploadTask = firebaseStorage.ref().child(ref).putFile(file);
    //* تستخدم للحصول على معلومات عمليات الرفع
    TaskSnapshot snap = await uploadTask;
    //* تستخدم للحصول على رابط تحميل الملف الذي تم رفعه من ثمة ارجاعه
    String downlodUrl = await snap.ref.getDownloadURL();
    return downlodUrl;
  }
}
