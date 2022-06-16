import 'package:flutter/material.dart';

import '../navigationBar.dart';

class PremierScrean extends StatefulWidget {
  const PremierScrean({Key? key}) : super(key: key);

  @override
  _PremierScreanState createState() => _PremierScreanState();
}

class _PremierScreanState extends State<PremierScrean> {
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
        xofset = 230;
        yofset = 150;
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
    return GestureDetector(
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
        duration: const Duration(milliseconds: 270),
        transform: Matrix4.translationValues(xofset, yofset, 0)
          ..scale(scaleFactore),
        decoration: BoxDecoration(
          // color: Colors.amber,
          borderRadius:
              BorderRadius.all(Radius.circular(isDrowerOpen ? 30 : 0)),
        ),
        child: AbsorbPointer(
          absorbing: isDrowerOpen,
          child: MyApp1(
            openDrawer: openDrawer,
            isDrowerOpen: isDrowerOpen,
          ),
        ),
      ),
    );
  }
}
