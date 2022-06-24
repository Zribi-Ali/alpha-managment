import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: widget.publication.img != null
          ? SlidingUpPanel(
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
              body: Stack(
                children: [
                  Image.network(
                    widget.publication.img,
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height * .51,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.arrowLeft,
                        color: Colors.black.withOpacity(.7),
                        size: 26,
                      ),
                    ),
                  ),
                ],
              ),
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
                          color: Colors.red.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      widget.publication.titre,
                      style: textTheme.headline6,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .25,
                      child: Text(
                        widget.publication.content,
                        style: textTheme.caption,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(
                      color: Colors.black.withOpacity(0.3),
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        FaIcon(
                          FontAwesomeIcons.gratipay,
                          color: Colors.red.withOpacity(.7),
                          size: 30,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${widget.publication.likers.length}",
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        Container(
                          width: 2,
                          height: 30,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        FaIcon(
                          FontAwesomeIcons.commentDots,
                          size: 30,
                          color: Colors.red.withOpacity(.7),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${widget.publication.comments.length}",
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            )
          : Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  child: AnimatedContainer(
                    height: 80,
                    duration: const Duration(milliseconds: 400),
                    child: AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      leading: IconButton(
                        icon: FaIcon(
                          FontAwesomeIcons.arrowLeft,
                          color: Colors.black.withOpacity(.7),
                          size: 26,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .09,
                ),
                Card(
                  shadowColor: Colors.red.withOpacity(.7),
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * .553,
                      width: MediaQuery.of(context).size.width * .9,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              height: 5,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            widget.publication.titre,
                            style: textTheme.headline6,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .25,
                            child: Text(
                              widget.publication.content,
                              style: textTheme.caption,
                            ),
                          ),
                          const SizedBox(
                            height: 100,
                          ),
                          Divider(
                            color: Colors.black.withOpacity(0.3),
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              FaIcon(
                                FontAwesomeIcons.gratipay,
                                color: Colors.red.withOpacity(.7),
                                size: 30,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${widget.publication.likers.length}",
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                              Container(
                                width: 2,
                                height: 30,
                                color: Colors.black,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              FaIcon(
                                FontAwesomeIcons.commentDots,
                                size: 30,
                                color: Colors.red.withOpacity(.7),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${widget.publication.comments.length}",
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
