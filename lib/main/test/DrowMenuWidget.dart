import 'package:flutter/material.dart';

class DrawMenuWidgit extends StatelessWidget {
  final VoidCallback onClicked;
  DrawMenuWidgit(
      {Key? key, required this.onClicked, required this.isDrowerOpen})
      : super(key: key);
  bool isDrowerOpen;
  @override
  Widget build(BuildContext context) {
    return isDrowerOpen
        ? IconButton(
            iconSize: 20.0,
            icon: const Icon(Icons.arrow_back_ios_new),
            color: Colors.black,
            onPressed: () {})
        : IconButton(
            iconSize: 20.0,
            icon: const Icon(Icons.menu),
            color: Colors.black,
            onPressed: onClicked);
  }
}


/*
isDrowerOpen
            ? IconButton(
                iconSize: 20.0,
                focusColor: Colors.grey[300],
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    xofset = 0;
                    yofset = 0;
                    scaleFactore = 1;
                    isDrowerOpen = false;
                  });

                  ;
                },
              )
            : IconButton(
                iconSize: 20.0,
                icon: const Icon(Icons.menu),
                color: Colors.black,
                onPressed: () {
                  setState(() {
                    xofset = 200;
                    yofset = 100;
                    scaleFactore = 0.7;
                    isDrowerOpen = true;
                  });
                },
              ),
 */