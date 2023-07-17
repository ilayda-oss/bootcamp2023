import 'package:diyet_asistanim/core/constants/colors.dart';
import 'package:diyet_asistanim/core/constants/consts.dart';

Widget orderStatus({icon, color, title, showDone}) {
  return ListTile(
    leading: Icon(icon, color: color)
        .box
        .border(color: color)
        .roundedSM
        .padding(const EdgeInsets.all(4))
        .make(),
    trailing: SizedBox(
      height: 100,
      width: 160,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          "$title".text.color(ColorConstants.darkCharcoal).make(),
          showDone
              ? const Icon(Icons.done, color: ColorConstants.red)
              : Container(),
        ],
      ),
    ),
  );
}
