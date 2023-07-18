import 'package:dietmateapp/screens/ai.dart';

import 'package:dietmateapp/screens/foods.dart';
import 'package:dietmateapp/screens/health.dart';
import 'package:dietmateapp/screens/profile.dart';
import 'package:flutter/material.dart';

class Aimain extends StatefulWidget {
  const Aimain({super.key});

  @override
  AimainState createState() => AimainState();
}

class AimainState extends State<Aimain> with SingleTickerProviderStateMixin {
  late TabController _tabcontroller;
  bool ShowPage = true;

  @override
  void initState() {
    _tabcontroller = TabController(length: 4, vsync: this, initialIndex: 1);
    _tabcontroller.addListener(() {
      ShowPage = _tabcontroller.index == 0;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Diet Mate"),
        bottom: TabBar(controller: _tabcontroller, tabs: <Widget>[
          Tab(icon: Icon(Icons.person)),
          Tab(text: "My Health"),
          Tab(text: "My AI"),
          Tab(text: "Advised Food"),
        ]),
      ),
      body: TabBarView(
        controller: _tabcontroller,
        children: <Widget>[
          ProfilePage(),
          HealthPage(),
          AIPage(),
          FoodsPage(),
        ],
      ),
      floatingActionButton: ShowPage
          ? FloatingActionButton(child: Icon(Icons.message), onPressed: () {})
          : null,
    );
  }
}
