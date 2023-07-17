import 'package:diyet_asistanim/core/constants/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onInit() {
    getUsername();
    getUseremail();
    getUsersurname();
    getUserimg();
    super.onInit();
  }

  var currentNavIndex = 0.obs;

  var searchController = TextEditingController();

  var username = '';
  var surname = '';
  var email = '';
  var img = '';

  getUsername() async {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    var n = await firestore
        .collection(usersCollection)
        .where('id', isEqualTo: uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['name'];
      }
    });
    username = n;
  }

  getUsersurname() async {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    var n = await firestore
        .collection(usersCollection)
        .where('id', isEqualTo: uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['surname'];
      }
    });
    surname = n;
  }

  getUseremail() async {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    var n = await firestore
        .collection(usersCollection)
        .where('id', isEqualTo: uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['email'];
      }
    });
    email = n;
  }

  getUserimg() async {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    var n = await firestore
        .collection(usersCollection)
        .where('id', isEqualTo: uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['imageUrl'];
      }
    });
    img = n;
  }
}
