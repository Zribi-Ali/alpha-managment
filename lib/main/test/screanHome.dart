import 'package:alpha/Models/Publication.dart';
import 'package:flutter/material.dart';
import '../../Screans/Publication/PublicationPage.dart';

import '../Configuration/build_list.dart';
import '../navigationBar.dart';
import 'DrowMenuWidget.dart';

class ScreanHome extends StatefulWidget {
  const ScreanHome({Key? key}) : super(key: key);

  @override
  _PremierScreanState createState() => _PremierScreanState();
}

class _PremierScreanState extends State<ScreanHome> {
  double xofset = 0;
  double yofset = 0;
  double scaleFactore = 1;
  bool isDrowerOpen = false;
  bool isDragging = false;

  @override
  void initState() {
    super.initState();
  }

  void openDrawer() => setState(() {
        xofset = 210;
        yofset = 130;
        scaleFactore = 0.7;
        isDrowerOpen = true;
      });

  void closeDrawer() => setState(() {
        xofset = 0;
        yofset = 0;
        scaleFactore = 1;
        isDrowerOpen = false;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: closeDrawer,
        onHorizontalDragStart: (details) => isDragging = true,
        onHorizontalDragUpdate: (details) {
          if (!isDragging) return;
          const delta = 1;
          if (details.delta.dx > delta) {
            openDrawer();
          } else if (details.delta.dx < -delta) {
            closeDrawer();
          }
          isDragging = false;
        },
        child: AnimatedContainer(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(isDrowerOpen ? 30 : 0),
          ),
          duration: const Duration(milliseconds: 270),
          transform: Matrix4.translationValues(xofset, yofset, 0)
            ..scale(scaleFactore),
          child: AbsorbPointer(
            absorbing: isDrowerOpen,
            child: TEbController(
                openDrawer: openDrawer, isDrowerOpen: isDrowerOpen),
          ),
        ),
      ),
    );
  }
}
