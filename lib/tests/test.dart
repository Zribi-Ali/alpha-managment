import 'package:alpha/tests/test_butt2.dart';
import 'package:alpha/tests/test_butt1.dart';
import 'package:alpha/tests/test_button_like.dart';
import 'package:alpha/tests/test_comment.dart';
import 'package:flutter/material.dart';

import 'test_comment2.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
                elevation: 0,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyCustomWidget1()));
              },
              child: Text("test_butt1"),
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
                elevation: 0,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyCustomWidget2()));
              },
              child: Text("test_butt2"),
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
                elevation: 0,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyCustomWidget3()));
              },
              child: Text("test_butt1"),
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
                elevation: 0,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyCustomWidget4()));
              },
              child: Text("test_butt1"),
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
                elevation: 0,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyCustomUI()));
              },
              child: Text("test_butt1"),
            ),
          ],
        ),
      ),
    );
  }
}
