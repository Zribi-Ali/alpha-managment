import 'dart:io';
import 'dart:convert';
import 'package:alpha/Models/Publication.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ProfileWidget extends StatefulWidget {
  final String imagePath;
  final double h;
  final double l;
  final VoidCallback onClicked;
  const ProfileWidget({
    Key? key,
    required this.imagePath,
    required this.onClicked,
    required this.h,
    required this.l,
  }) : super(key: key);

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  File? imag;
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Center(
      child: Stack(children: [
        buildImage(),
        Positioned(
          child: buildEditIcon(Colors.teal),
          bottom: 0,
          right: 4,
        )
      ]),
    );
  }

  Widget buildImage() {
    return ClipOval(
      child: Material(
        // color: Colors.transparent,
        child: InkWell(
          onTap: () {
            pickImage();
          },
          child: SizedBox(
              height: 170,
              width: 165,
              child: Image.network(
                widget.imagePath,
                fit: BoxFit.cover,
              )),
        ),
      ),
    );
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() => this.imag = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Widget buildEditIcon(Color color) => buildCircle(
      color: Colors.white,
      all: 3,
      child: buildCircle(
        color: color,
        all: 8,
        child: const Icon(
          Icons.edit,
          color: Colors.white,
          size: 20,
        ),
      ));

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
