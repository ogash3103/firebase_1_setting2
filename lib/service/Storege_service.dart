import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class SotreSevice{
  static final _storageRef =FirebaseStorage.instance.ref();

  static final folder = "post_images";

  static Future<String> uploadImage(File _image) async{
    String img_name = "image_" + DateTime.now().toString();
    var firebaseStorageRef =  _storageRef.child(folder).child(img_name);
    var uploadTask = firebaseStorageRef.putFile(_image);
    final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});
    String  downloadUrl = await firebaseStorageRef.getDownloadURL();
    print(downloadUrl);
    return downloadUrl;
  }
  }

