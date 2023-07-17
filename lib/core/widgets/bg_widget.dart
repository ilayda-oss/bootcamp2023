import 'package:diyet_asistanim/core/widgets/applogo_widget.dart';

Widget bgWidget({Widget? child, String? assetName}) {
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
          image: AssetImage(assetName!),
          alignment: Alignment.topCenter,
          fit: BoxFit.fitWidth),
    ),
    child: child,
  );
}
