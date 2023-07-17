import 'package:diyet_asistanim/core/constants/strings.dart';
import 'package:diyet_asistanim/core/init/theme/app_theme.dart';
import 'package:diyet_asistanim/views/splash_screen/view/splash_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: StringConstants.appName,
      theme: AppTheme(context).theme,
      home: const SplashView(),
    );
  }
}
