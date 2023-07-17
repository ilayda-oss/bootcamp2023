import 'package:flutter/material.dart';

@immutable
class AppTheme {
  const AppTheme(this.context);
  final BuildContext context;

  ThemeData get theme => ThemeData.light().copyWith();
}
