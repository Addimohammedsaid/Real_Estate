import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class UploadImage {
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: "gs://real-estate-b1bb0.appspot.com");

  StorageUploadTask _uploadTask;

  StorageUploadTask startUpload(File file, String path) {
    try {
      String filePath = 'properties/$path/main.png';
      _uploadTask = _storage.ref().child(filePath).putFile(file);
      return _uploadTask;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
