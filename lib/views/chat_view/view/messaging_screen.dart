import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diyet_asistanim/core/constants/colors.dart';
import 'package:diyet_asistanim/core/constants/images.dart';
import 'package:diyet_asistanim/core/constants/styles.dart';
import 'package:diyet_asistanim/services/firestore_services.dart';
import 'package:diyet_asistanim/views/chat_view/view/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const BackButton(color: ColorConstants.darkCharcoal),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: "Mesajlar"
            .text
            .color(ColorConstants.darkCharcoal)
            .fontFamily(FontConstants.medium)
            .make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getAllMessages(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(IconConstants.background.toPng),
                      fit: BoxFit.cover)),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(IconConstants.background.toPng),
                        fit: BoxFit.cover)),
                child: const Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation(ColorConstants.greenCrayola),
                  ),
                ),
              ),
            );
          } else if (snapshot.data!.docChanges.isEmpty) {
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(IconConstants.background.toPng),
                      fit: BoxFit.cover)),
              child: Center(
                child: "Henüz mesajınız yok!"
                    .text
                    .fontFamily(FontConstants.semibold)
                    .color(ColorConstants.darkCharcoal)
                    .makeCentered(),
              ),
            );
          } else {
            var data = snapshot.data!.docs;
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(IconConstants.background.toPng),
                      fit: BoxFit.cover)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            semanticContainer: true,
                            elevation: 5,
                            child: ListTile(
                              onTap: () {
                                Get.to(() => const ChatScreen(), arguments: [
                                  data[index]['friend_name'],
                                  data[index]['friend_surname'],
                                  data[index]['toId']
                                ]);
                              },
                              leading: const CircleAvatar(
                                backgroundColor: ColorConstants.greenCrayola,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                              ),
                              title: "${data[index]['friend_name']}"
                                  .text
                                  .fontFamily(FontConstants.semibold)
                                  .color(ColorConstants.darkCharcoal)
                                  .make(),
                              subtitle:
                                  "${data[index]['last_msg']}".text.make(),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
