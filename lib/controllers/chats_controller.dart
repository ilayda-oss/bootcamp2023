import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diyet_asistanim/controllers/home_controller.dart';
import 'package:diyet_asistanim/core/constants/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ChatsController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onInit() {
    getChatId();
    super.onInit();
  }

  var chats = firestore.collection(chatsCollection);

  var friendName = Get.arguments[0];
  var friendSurname = Get.arguments[1];
  var friendId = Get.arguments[2];

  var senderName = Get.find<HomeController>().username;

  var msgController = TextEditingController();

  dynamic chatDocId;

  var isLoading = false.obs;

  getChatId() async {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    var currentId = uid;
    isLoading(true);
    await chats
        .where('users', isEqualTo: {friendId: null, currentId: null})
        .limit(1)
        .get()
        .then((QuerySnapshot snapshot) {
          if (snapshot.docs.isNotEmpty) {
            chatDocId = snapshot.docs.single.id;
          } else {
            chats.add({
              'created_on': null,
              'last_msg': null,
              'users': {friendId: null, currentId: null},
              'toId': '',
              'fromId': '',
              'friend_name': friendName,
              'friend_surname': friendSurname,
              'sender_name': senderName,
            }).then((value) {
              chatDocId = value.id;
            });
          }
        });
    isLoading(false);
  }

  sendMsg(String msg) async {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    var currentId = uid;
    if (msg.trim().isNotEmpty) {
      chats.doc(chatDocId).update({
        'created_on': FieldValue.serverTimestamp(),
        'last_msg': msg,
        'toId': friendId,
        'fromId': currentId,
      });
      chats.doc(chatDocId).collection(messagesCollection).doc().set({
        'created_on': FieldValue.serverTimestamp(),
        'msg': msg,
        'uid': currentId,
      });
    }
  }
}
