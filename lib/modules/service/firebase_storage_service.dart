import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gamers_hub/utils/config/firebase_collections.dart';

class FirebaseStorageService {
  final FirebaseStorage _client = FirebaseStorage.instance;

  Future<String?> uploadFile({required String id, required String filePath}) async {
    try {
      final file = File(filePath);
      if (!await file.exists()) {
        throw Exception("File not found at $filePath");
      }

      final Reference ref = _client.ref(FirebaseCollections.profileCollectionPath).child(id);

      final UploadTask uploadTask = ref.putFile(file);

      // Wait for the upload to finish and retrieve the download URL
      final TaskSnapshot snapshot = await uploadTask;
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      // log(downloadUrl);

      return downloadUrl;
    } catch (e) {
      log ("Error uploading file: $e");
      return null;
    }
  }
}
