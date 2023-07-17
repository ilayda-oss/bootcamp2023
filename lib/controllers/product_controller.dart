import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diyet_asistanim/core/constants/consts.dart';
import 'package:diyet_asistanim/models/category_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var subcat = [];

  var isFav = false.obs;

  getSubCategories(title) async {
    subcat.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decoded = categoryModelFromJson(data);
    var s =
        decoded.categories.where((element) => element.name == title).toList();

    for (var e in s[0].subcategory) {
      subcat.add(e);
    }
  }

  addToCard({surname, img, dietitianname, tprice, context, dietitianID}) async {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    await firestore.collection(cartCollection).doc().set({
      'surname': surname,
      'img': img,
      'dietitianname': dietitianname,
      'dietitian_id': dietitianID,
      'tprice': tprice,
      'added_by': uid
    }).catchError((error) {
      VxToast.show(context, msg: error.toString());
    });
  }

  addToWishlist(docId, context) async {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    await firestore.collection(productCollection).doc(docId).set({
      'd_wishlist': FieldValue.arrayUnion([uid])
    }, SetOptions(merge: true));
    isFav(true);
    VxToast.show(context, msg: "Favorilere eklendi");
  }

  removeFromWishlist(docId, context) async {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    await firestore.collection(productCollection).doc(docId).set({
      'd_wishlist': FieldValue.arrayRemove([uid])
    }, SetOptions(merge: true));
    isFav(false);
    VxToast.show(context, msg: "Favorilerden silindi");
  }

  checkIfFav(data) async {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    if (data['d_wishlist'].contains(uid)) {
      isFav(true);
    } else {
      isFav(false);
    }
  }
}
