import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'modifier.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  const ButtonWidget({
    Key? key,
    required this.text,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          onPrimary: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 18.0),
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Modify()));
        },
      );
}
