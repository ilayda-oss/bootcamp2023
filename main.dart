import 'package:dietmateapp/aimain.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MyHomeScreen",
      theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 65, 218, 200),
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: const Color.fromARGB(255, 139, 129, 233))),
      home: const Aimain(),
    );
  }
}
