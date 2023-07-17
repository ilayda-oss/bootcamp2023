import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diyet_asistanim/controllers/chats_controller.dart';
import 'package:diyet_asistanim/core/constants/colors.dart';
import 'package:diyet_asistanim/core/constants/consts.dart';
import 'package:diyet_asistanim/core/constants/images.dart';
import 'package:diyet_asistanim/core/constants/styles.dart';
import 'package:diyet_asistanim/services/firestore_services.dart';
import 'package:diyet_asistanim/views/chat_view/components/sender_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    var controller = Get.put(ChatsController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const BackButton(color: ColorConstants.darkCharcoal),
        title: "${controller.friendName} ${controller.friendSurname}"
            .text
            .fontFamily(FontConstants.medium)
            .color(ColorConstants.darkCharcoal)
            .size(18)
            .make(),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(IconConstants.background.toPng),
                fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Obx(
                () => controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation(ColorConstants.greenCrayola),
                      ))
                    : Expanded(
                        child: StreamBuilder(
                            stream: FirestoreServices.getChatMessages(
                                controller.chatDocId.toString()),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                    child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(
                                      ColorConstants.greenCrayola),
                                ));
                              } else if (snapshot.data!.docs.isEmpty) {
                                return Center(
                                  child: "Mesaj yaz..."
                                      .text
                                      .color(ColorConstants.darkCharcoal)
                                      .make(),
                                );
                              } else {
                                return ListView(
                                    children: snapshot.data!.docs
                                        .mapIndexed((currentValue, index) {
                                  var data = snapshot.data!.docs[index];
                                  return Align(
                                      alignment: data['uid'] == uid
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                      child: senderBubble(data));
                                }).toList());
                              }
                            })),
              ),
              10.heightBox,
              Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    controller: controller.msgController,
                    decoration: const InputDecoration(
                      hintText: "Mesaj yaz...",
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ColorConstants.darkBlueGray)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ColorConstants.darkBlueGray)),
                    ),
                  )),
                  IconButton(
                      onPressed: () {
                        controller.sendMsg(controller.msgController.text);
                        controller.msgController.clear();
                      },
                      icon: const Icon(
                        Icons.send_rounded,
                        color: ColorConstants.greenCrayola,
                      )),
                ],
              )
                  .box
                  .height(80)
                  .padding(const EdgeInsets.all(12))
                  .margin(const EdgeInsets.only(bottom: 8))
                  .make(),
            ],
          ),
        ),
      ),
    );
  }
}
