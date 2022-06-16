import 'package:alpha/Provider/myprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Routes.dart';
import '../Class/class.dart';
import '../Class/cours.dart';
import '../Class/listclass.dart';
import '../Publication/listPublication.dart';

class NumbersWidget extends StatefulWidget {
  @override
  State<NumbersWidget> createState() => _NumbersWidgetState();
}

class _NumbersWidgetState extends State<NumbersWidget> {
  @override
  Widget build(BuildContext context) => IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListClass()),
                );
              },
              child: buildButton(context, 'Class'),
            ),
            buildDivider(),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListPublication()),
                );
              },
              child: buildButton(
                context,
                'Publications',
              ),
            )
          ],
        ),
      );

  Widget buildDivider() => const SizedBox(
        height: 32,
        child: VerticalDivider(),
      );

  Widget buildButton(BuildContext context, String test) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 6),
          Text(
            test,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
          ),
        ],
      ),
    );
  }
}
