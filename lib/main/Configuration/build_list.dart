/* import 'package:flutter/material.dart';


// ignore: unused_element
Widget buildList({required List<ShoeModel> items}) {
  return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return index % 2 == 0
            ? FadeInLeft(
                duration: const Duration(milliseconds: 600),
                from: 400,
                child: BuildItem(items: items, index: index))
            : FadeInRight(
                duration: const Duration(milliseconds: 600),
                from: 400,
                child: BuildItem(items: items, index: index),
              );
      });
}
 */

import 'package:flutter/material.dart';

import '../../Screans/Publication/PublicationPage.dart';
import '../test/DrowMenuWidget.dart';

class TEbController extends StatefulWidget {
  TEbController(
      {Key? key, required this.openDrawer, required this.isDrowerOpen})
      : super(key: key);
  bool isDrowerOpen;
  final VoidCallback openDrawer;
  @override
  State<TEbController> createState() => _TEbControllerState();
}

class _TEbControllerState extends State<TEbController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: DrawMenuWidgit(
            onClicked: widget.openDrawer, isDrowerOpen: widget.isDrowerOpen),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: DefaultTabController(
          length: 2,
          child: Column(children: const [
            TabBar(
              labelColor: Colors.black,
              tabs: [
                Tab(
                  text: 'Publicatiçon',
                ),
                Tab(
                  text: 'Class',
                ),
              ],
            )
          ])),
    );
  }
}
