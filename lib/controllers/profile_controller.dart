import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diyet_asistanim/core/constants/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class ProfileController extends GetxController {
  var profileImgPath = ''.obs;
  var profileImgageLink = '';
  FirebaseAuth auth = FirebaseAuth.instance;

  var isLoading = false.obs;

  var nameController = TextEditingController();
  var oldpasswordController = TextEditingController();
  var newpasswordController = TextEditingController();

  changeImage(context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 70);
      if (img == null) return;
      profileImgPath.value = img.path;
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadProfileImage() async {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    var filename = basename(profileImgPath.value);
    var destination = 'images/$uid/$filename';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImgPath.value));
    profileImgageLink = await ref.getDownloadURL();
  }

  updateProfile({name, password, imgUrl}) async {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    var store = firestore.collection(usersCollection).doc(uid);
    await store.set({'name': name, 'password': password, 'imageUrl': imgUrl},
        SetOptions(merge: true));
    isLoading(false);
  }

  changeAuthPassword({email, password, newpassword}) async {
    final cred = EmailAuthProvider.credential(email: email, password: password);
    final User? user = auth.currentUser;
    // ignore: unused_local_variable
    final uid = user!.uid;

    await user.reauthenticateWithCredential(cred).then((value) {
      user.updatePassword(newpassword);
    }).catchError((error) {});
  }
}
