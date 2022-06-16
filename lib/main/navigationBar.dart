// ignore_for_file: prefer_const_constructors

import 'package:alpha/Screans/evenement/Evenement.dart';
import 'package:alpha/Screans/Profile/Profile.dart';
import 'package:alpha/main/test/DrowMenuWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../Screans/Publication/PublicationPage.dart';
import '../Screans/Publication/addpublication.dart';

class MyApp1 extends StatefulWidget {
  MyApp1({Key? key, required this.openDrawer, required this.isDrowerOpen})
      : super(key: key);
  final VoidCallback openDrawer;
  bool isDrowerOpen;
  @override
  State<MyApp1> createState() => _MyApp1State();
}

class _MyApp1State extends State<MyApp1> {
  PersistentTabController controller = PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(widget.isDrowerOpen ? 12.0 : 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(widget.isDrowerOpen ? 30 : 0),
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: DrawMenuWidgit(
              onClicked: widget.openDrawer, isDrowerOpen: widget.isDrowerOpen),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: PersistentTabView(
          context,
          controller: controller,
          screens: _buildScreens(),
          items: _navBarsItems(),
          confineInSafeArea: true,
          backgroundColor: Colors.white,
          handleAndroidBackButtonPress: true,
          resizeToAvoidBottomInset: true,
          stateManagement: true,
          hideNavigationBarWhenKeyboardShows: true,
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(10.0),
            colorBehindNavBar: Colors.white,
          ),
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          itemAnimationProperties: ItemAnimationProperties(
            duration: Duration(milliseconds: 150),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: ScreenTransitionAnimation(
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          navBarStyle: NavBarStyle.style3,
        ),
      ),
    );
  }

  List<Widget> _buildScreens() {
    return [
      AffichPublication(),
      EvenementAff(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.plus_bubble_fill),
        title: ("Publication"),
        activeColorPrimary: Color.fromARGB(255, 40, 155, 170),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.plus_bubble_fill),
        title: ("Evenement"),
        activeColorPrimary: Color.fromARGB(255, 40, 155, 170),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.bag_fill),
        title: ("Classe"),
        activeColorPrimary: Color.fromARGB(255, 40, 155, 170),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }
}


/*

 */