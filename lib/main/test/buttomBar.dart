import 'package:alpha/Screans/evenement/Evenement.dart';
import 'package:alpha/Screans/formation/Formation.dart';
import 'package:alpha/Screans/Profile/Profile.dart';
import 'package:alpha/Screans/Publication/PublicationPage.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;
  List<IconData> data = [
    Icons.post_add,
    Icons.event_available_outlined,
    Icons.person,
    Icons.format_shapes_outlined
  ];

  final screans = [
    AffichPublication(),
    EvenementAff(),
    Profile(),
    FormationA()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screans[selectedIndex],
      //backgroundColor: Colors.transparent,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(60),
          color: Colors.black,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
            ),
            height: 50,
            width: double.infinity,
            child: ListView.builder(
              itemCount: data.length,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemBuilder: (ctx, i) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = i;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: 35,
                    decoration: BoxDecoration(
                      border: i == selectedIndex
                          ? const Border(
                              top: BorderSide(width: 3.0, color: Colors.white),
                            )
                          : null,
                      gradient: i == selectedIndex
                          ? LinearGradient(
                              colors: [Colors.grey.shade800, Colors.black],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter)
                          : null,
                    ),
                    child: Icon(
                      data[i],
                      size: 35,
                      color: i == selectedIndex
                          ? Colors.white
                          : Colors.grey.shade800,
                    ),
                  ),
                ),
              ),
              scrollDirection: Axis.horizontal,
            ),
          ),
        ),
      ),
    );
  }
}
