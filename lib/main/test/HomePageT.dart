import 'package:flutter/material.dart';

import 'buttomBar.dart';
import 'drawerscreanT.dart';
import 'page1.dart';
import 'screanHome.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DrowerScreane(),
        //PremierScrean(),
        //ScreanHome(),
        Home(),
      ],
    );
  }
}
