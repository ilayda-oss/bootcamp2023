import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diyet_asistanim/core/constants/colors.dart';
import 'package:diyet_asistanim/core/constants/consts.dart';
import 'package:diyet_asistanim/core/constants/images.dart';
import 'package:diyet_asistanim/core/constants/styles.dart';
import 'package:diyet_asistanim/services/firestore_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WishlistView extends StatelessWidget {
  const WishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const BackButton(color: ColorConstants.darkCharcoal),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: "İstek Listesi"
            .text
            .color(ColorConstants.darkCharcoal)
            .fontFamily(FontConstants.medium)
            .make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getWishlist(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Container(
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
            );
          } else if (snapshot.data!.docChanges.isEmpty) {
            return Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(IconConstants.background.toPng),
                      fit: BoxFit.cover)),
              child: Center(
                child: "İstek listesi boş!"
                    .text
                    .fontFamily(FontConstants.semibold)
                    .size(20)
                    .color(ColorConstants.darkCharcoal)
                    .makeCentered(),
              ),
            );
          } else {
            var data = snapshot.data!.docs;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            "${data[index]['d_imgs'][0]}",
                            fit: BoxFit.cover,
                          ),
                        ),
                        title:
                            "${data[index]['d_name']} ${data[index]['d_surname']}"
                                .text
                                .fontFamily(FontConstants.semibold)
                                .size(16)
                                .make(),
                        subtitle: "${data[index]['d_price']} ₺"
                            .text
                            .color(ColorConstants.darkCharcoal)
                            .fontFamily(FontConstants.medium)
                            .color(ColorConstants.red)
                            .size(10)
                            .make(),
                        trailing: const Icon(
                          Icons.favorite,
                          color: ColorConstants.red,
                        ).onTap(() async {
                          await firestore
                              .collection(productCollection)
                              .doc(data[index].id)
                              .set({
                            'd_wishlist': FieldValue.arrayRemove([uid])
                          }, SetOptions(merge: true));
                        }),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
