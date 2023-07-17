import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diyet_asistanim/core/constants/colors.dart';
import 'package:diyet_asistanim/core/constants/consts.dart';
import 'package:diyet_asistanim/core/constants/styles.dart';
import 'package:diyet_asistanim/core/widgets/dietitian_card_horizontal.dart';
import 'package:diyet_asistanim/services/firestore_services.dart';
import 'package:diyet_asistanim/views/category_screen/view/category_details_view.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  final String? title;
  const SearchScreen({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.lightGrey,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: ColorConstants.darkCharcoal),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: "Diyetisyenler"
            .text
            .color(ColorConstants.darkCharcoal)
            .fontFamily(FontConstants.medium)
            .make(),
      ),
      body: FutureBuilder(
        future: FirestoreServices.searchProducts(title),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(ColorConstants.greenCrayola),
              ),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Expanded(
              child: "Diyetisyen bulunamadı"
                  .text
                  .color(ColorConstants.darkCharcoal)
                  .makeCentered(),
            );
          } else {
            var data = snapshot.data!.docs;
            var filtered = data
                .where((element) => element['d_name']
                    .toString()
                    .toLowerCase()
                    .contains(title!.toLowerCase()))
                .toList();
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    mainAxisExtent: 270),
                children: filtered
                    .mapIndexed((currentValue, index) =>
                        DietitianCardHorizontal(
                                height: 200,
                                width: 200,
                                textButton:
                                    "${filtered[index]['d_name']} ${filtered[index]['d_surname']}",
                                image: filtered[index]['d_imgs'][0],
                                specialty: filtered[index]['d_category'])
                            .onTap(() {
                          Get.to(() => CategoryDetailsView(
                                data: filtered[index],
                              ));
                        }))
                    .toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
