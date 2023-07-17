import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../constants/colors.dart';

Widget customTextField({String? hint, controller, isPass, myFocusNode}) {
  return Column(
    children: [
      TextFormField(
        obscureText: isPass,
        controller: controller,
        decoration: InputDecoration(
          labelText: hint,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          isDense: true,
          fillColor: ColorConstants.platinum,
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: ColorConstants.greenCrayola,
            ),
          ),
        ),
      ),
      20.heightBox
    ],
  );
}
