import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/myprovider.dart';
import '../Screans/Profile/image.dart';

class ImageP extends StatefulWidget {
  const ImageP({
    Key? key,
  }) : super(key: key);

  @override
  State<ImageP> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ImageP> {
  var img;
  @override
  Widget build(BuildContext context) {
    img = Provider.of<MyProvider>(context).image;
    return Center(
      child: Stack(children: [
        ProfileWidget(
          h: 100,
          imagePath: img,
          l: 100,
          onClicked: () {},
        ),
      ]),
    );
  }
}
