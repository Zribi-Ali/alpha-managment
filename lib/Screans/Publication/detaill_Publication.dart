import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class DetailPub extends StatefulWidget {
  const DetailPub({Key? key, required this.publication}) : super(key: key);
  final publication;
  @override
  State<DetailPub> createState() => _DetailPubState();
}

class _DetailPubState extends State<DetailPub> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final _textTheme = Theme.of(context).textTheme;

    return Scaffold(
        body: SlidingUpPanel(
      parallaxEnabled: true,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      minHeight: (size.height / 2),
      maxHeight: size.height / 1.2,
      panel: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 5,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              widget.publication.titre,
              style: _textTheme.headline6,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.publication.content,
              style: _textTheme.caption,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "${widget.publication.likers.length}",
                ),
                const SizedBox(
                  width: 10,
                ),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  width: 2,
                  height: 30,
                  color: Colors.black,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Divider(
              color: Colors.black.withOpacity(0.3),
            ),
          ],
        ),
      ),
    ));
  }
}
