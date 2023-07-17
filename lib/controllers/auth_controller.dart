import 'package:diyet_asistanim/core/constants/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;

  //Textcontrollers
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  //Login Method
  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  //Signup Method
  Future<UserCredential?> signupMethod({email, password, context}) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  //storing data method

  void storeUserData({name, surname, password, email}) async {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    await firestore.collection(usersCollection).doc(uid).set({
      'name': name,
      'surname': surname,
      'password': password,
      'email': email,
      'imageUrl': '',
      'id': uid,
      'aiList': '',
      'fav_dietitian_count': "00",
      'total_diet': "00",
    });
  }

  //sigout Method
  signoutMethod(context) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}
