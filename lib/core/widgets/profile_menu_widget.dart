import 'package:diyet_asistanim/core/constants/colors.dart';
import 'package:diyet_asistanim/core/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileMenuWidget extends StatelessWidget {
  final String text;
  final Color? textColor;
  final IconData icon;
  final VoidCallback onPress;
  const ProfileMenuWidget({
    super.key,
    required this.text,
    required this.icon,
    required this.onPress,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: ColorConstants.greenCrayola.withOpacity(0.1),
        ),
        child: Icon(
          icon,
          color: ColorConstants.greenCrayola,
        ),
      ),
      title: text.text
          .fontFamily(FontConstants.semibold)
          .color(textColor ?? textColor)
          .make(),
      trailing: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: ColorConstants.greenCrayola.withOpacity(0.1),
        ),
        child: const Icon(
          LineAwesomeIcons.angle_right,
          color: ColorConstants.coolGrey,
        ),
      ),
    );
  }
}
