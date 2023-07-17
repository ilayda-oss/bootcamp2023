import 'package:diyet_asistanim/core/constants/colors.dart';
import 'package:diyet_asistanim/core/constants/consts.dart';
import 'package:diyet_asistanim/core/constants/styles.dart';

Widget orderPlaceDetails(data, title1, title2, d1, d2) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "$title1".text.fontFamily(FontConstants.semibold).make(),
            "$d1"
                .text
                .color(ColorConstants.red)
                .fontFamily(FontConstants.semibold)
                .make(),
          ],
        ),
        SizedBox(
          width: 90,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "$title2".text.fontFamily(FontConstants.semibold).make(),
              "$d2".text.make(),
            ],
          ),
        ),
      ],
    ),
  );
}
