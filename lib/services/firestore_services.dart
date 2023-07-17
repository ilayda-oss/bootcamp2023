import 'package:diyet_asistanim/core/constants/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreServices {
  //get users data
  static getUser(uid) {
    return firestore
        .collection(usersCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  static getProducts(category) {
    return firestore
        .collection(productCollection)
        .where('d_category', isEqualTo: category)
        .snapshots();
  }

  static getAllProducts() {
    return firestore.collection(productCollection).snapshots();
  }

  static getCard(uid) {
    return firestore
        .collection(cartCollection)
        .where('added_by', isEqualTo: uid)
        .snapshots();
  }

  static deleteDocument(docId) {
    return firestore.collection(cartCollection).doc(docId).delete();
  }

  static getChatMessages(docId) {
    return firestore
        .collection(chatsCollection)
        .doc(docId)
        .collection(messagesCollection)
        .orderBy('created_on', descending: false)
        .snapshots();
  }

  static getAllOrders() {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    return firestore
        .collection(ordersCollection)
        .where('order_by', isEqualTo: uid)
        .snapshots();
  }

  static getWishlist() {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    return firestore
        .collection(productCollection)
        .where('d_wishlist', arrayContains: uid)
        .snapshots();
  }

  static getAllMessages() {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    return firestore
        .collection(chatsCollection)
        .where('fromId', isEqualTo: uid)
        .snapshots();
  }

  static getCounts() async {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    var res = await Future.wait([
      firestore
          .collection(cartCollection)
          .where('added_by', isEqualTo: uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      firestore
          .collection(productCollection)
          .where('d_wishlist', arrayContains: uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      firestore
          .collection(ordersCollection)
          .where('order_by', isEqualTo: uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
    ]);
    return res;
  }

  static getOnlineDietitian() {
    return firestore
        .collection(productCollection)
        .where('is_online', isEqualTo: true)
        .snapshots();
  }

  static getPopularDietitian() {
    return firestore
        .collection(productCollection)
        .where('is_popular', isEqualTo: true)
        .snapshots();
  }

  static searchProducts(title) {
    return firestore.collection(productCollection).get();
  }
}
