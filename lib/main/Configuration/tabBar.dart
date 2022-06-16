import 'package:flutter/material.dart';

import '../../Screans/Publication/PublicationPage.dart';

class BarTab extends StatefulWidget {
  const BarTab({Key? key}) : super(key: key);

  @override
  State<BarTab> createState() => _TabBarState();
}

class _TabBarState extends State<BarTab> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
          ),
        ]));
  }
}
