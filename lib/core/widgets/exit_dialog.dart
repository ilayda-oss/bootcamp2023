import 'package:diyet_asistanim/core/constants/colors.dart';
import 'package:diyet_asistanim/core/constants/consts.dart';
import 'package:diyet_asistanim/core/constants/styles.dart';
import 'package:flutter/services.dart';

Widget exitDialog(context) {
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Çık"
            .text
            .fontFamily(FontConstants.bold)
            .color(ColorConstants.darkCharcoal)
            .size(18)
            .make(),
        const Divider(),
        10.heightBox,
        "Uygulamadan çıkmak istediğinden emim misin?"
            .text
            .size(16)
            .align(TextAlign.center)
            .color(ColorConstants.darkCharcoal)
            .make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 100,
              height: 50,
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(ColorConstants.greenCrayola),
                  ),
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  child: "Evet"
                      .text
                      .red100
                      .fontFamily(FontConstants.semibold)
                      .make()),
            ),
            SizedBox(
              width: 100,
              height: 50,
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(ColorConstants.red),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: "Hayır"
                      .text
                      .red100
                      .fontFamily(FontConstants.semibold)
                      .make()),
            ),
          ],
        ),
      ],
    )
        .box
        .color(ColorConstants.white)
        .padding(const EdgeInsets.all(12))
        .rounded
        .make(),
  );
}
