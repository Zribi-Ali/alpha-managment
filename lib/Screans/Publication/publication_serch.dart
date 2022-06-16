import 'dart:async';
import 'dart:convert';

import 'package:alpha/Models/Publication.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../Connection.dart';
import '../../New Version/new_main.dart';
import '../../Provider/myprovider.dart';
import '../RCommentPage.dart';
import '../this/morphisme.dart';
import 'addpublication.dart';
import 'detaill_Publication.dart';
import 'modifier_pub.dart';
import 'search_widget.dart';

class FiltrePublication extends StatefulWidget {
  const FiltrePublication({Key? key}) : super(key: key);

  @override
  State<FiltrePublication> createState() => _FiltrePublicationState();
}

class _FiltrePublicationState extends State<FiltrePublication> {
  List<Publiucation> pubs = [];
  String query = '';
  Timer? debouncer;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
    controller.addListener(() {
      if (controller.position.userScrollDirection == ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          _showAppbar = false;
          setState(() {});
        }
      }

      if (controller.position.userScrollDirection == ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
          _showAppbar = true;
          setState(() {});
        }
      }
    });
    setState(() {
      init();
    });
  }

  @override
  void dispose() {
    debouncer?.cancel();
    controller = ScrollController();
    controller.dispose();
    controller.removeListener(() {});
    init();
    super.dispose();
  }

  final keyRef = GlobalKey<RefreshIndicatorState>();

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 600),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future<void> _lode() async {
    init();
  }

  bool _showAppbar = true;
  bool isScrollingDown = false;
  DemoConnection connection = DemoConnection();
  Future init() async {
    final pubs = await connection.fetchPubliucation();
    setState(() => this.pubs = pubs);
  }

  late ScrollController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            AnimatedContainer(
              height: _showAppbar ? 55.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NewMain(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black,
                  ),
                ),
                title: buildSearch(),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                key: keyRef,
                onRefresh: () async {
                  await _lode();
                },
                child: ListView.builder(
                  controller: controller,
                  shrinkWrap: true,
                  itemCount: pubs.length,
                  itemBuilder: (context, index) {
                    final pub = pubs[index];
                    return cardPub(pub);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: FloatingActionButton.extended(
          backgroundColor: Colors.blue.shade200,
          onPressed: () {
            pushNewScreen(
              context,
              screen: const AddPublication(),
              withNavBar: false,
            );
            setState(() {
              init();
            });
          },
          label: const Text(
            "New",
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Title or Content Name',
        onChanged: searchPub,
      );

  Future searchPub(String query) async => debounce(() async {
        final books = await DemoConnection.getPubs(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.pubs = books;
        });
      });

  Widget cardPub(publication) {
    final DemoConnection connection = DemoConnection();

    var id = Provider.of<MyProvider>(context, listen: false).id;
    String firstHalf;
    bool user;

    var likes = false;
    for (var i = 0; i < publication.likers.length; i++) {
      if (id == publication.likers[i]) {
        likes = true;
      }
    }

    if (Provider.of<MyProvider>(context).id == publication.user.id) {
      user = true;
    } else {
      user = false;
    }
    if (publication.content.length > 50) {
      firstHalf = publication.content.substring(0, 40);
    } else {
      firstHalf = publication.content;
    }

    return InkWell(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPub(
              publication: publication,
            ),
          ),
        ),
      },
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.blueGrey, width: 0.3),
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 10,
        shadowColor: Colors.blueGrey,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              ClipOval(
                                child: Material(
                                  child: SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: Image.network(
                                      publication.user.receipt,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${publication.user.nom} ${publication.user.prenom} ",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black.withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                          user == true
                              ? Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: ((context) =>
                                                PublicationModifier(
                                                  publication: publication,
                                                )),
                                          ),
                                        );
                                      },
                                      icon: FaIcon(
                                        FontAwesomeIcons.filePen,
                                        color: Colors.blue.shade300,
                                      ),
                                    ),
                                    IconButton(
                                      icon: const FaIcon(
                                        FontAwesomeIcons.trashCan,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              _buildPopupDialog(
                                                  context, publication),
                                        );
                                      },
                                    ),
                                  ],
                                )
                              : Container()
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.grey.shade400,
                      thickness: 1,
                    ),
                    Text(
                      "${publication.titre}",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(maxLines: 2, "$firstHalf ..."),
                        ],
                      ),
                    ),
                    TextButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text(
                            "show more",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => DetailPub(
                                  publication: publication,
                                )),
                          ),
                        );
                      },
                    ),
                    publication.img == null
                        ? Container()
                        : Center(
                            child: Image.network(publication.img),
                          ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey.shade400,
                thickness: 1,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: likes == false
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const FaIcon(
                                  FontAwesomeIcons.heart,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  connection.likepost(publication.id, id);

                                  setState(() {
                                    likes = true;
                                    init();
                                  });
                                },
                              ),
                              Text(
                                "${publication.likers.length}",
                                style: TextStyle(color: Colors.grey.shade400),
                              )
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.favorite_rounded,
                                  color: Colors.red,
                                  size: 30,
                                ),
                                onPressed: () {
                                  connection.unlikepost(publication.id, id);
                                  setState(() {
                                    likes = false;
                                    init();
                                  });
                                },
                              ),
                              Text(
                                "${publication.likers.length}",
                                style: TextStyle(color: Colors.grey.shade400),
                              )
                            ],
                          ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        children: [
                          IconButton(
                            hoverColor: Colors.black,
                            icon: const FaIcon(
                              FontAwesomeIcons.commentDots,
                              size: 30,
                            ),
                            onPressed: () {
                              pushNewScreen(
                                context,
                                screen: RCommentAffich(
                                  id: publication.id,
                                ),
                              );
                            },
                          ),
                          Text(
                            "${publication.comments.length}",
                            style: TextStyle(color: Colors.grey.shade400),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPopupDialog(BuildContext context, publication) {
    return AlertDialog(
      title: const Text('Vous être sûre ?'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
            onPressed: () {
              setState(() {
                connection.deletePublication(publication.id);
                Navigator.of(context).pop();
                init();
              });
            },
            child: const Text(
              "Supprimer",
              style: TextStyle(color: Colors.red, fontSize: 15),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget image(String img) {
    final _byteImage = Base64Decoder().convert(img);
    return Image.memory(_byteImage);
  }

  Widget buildDivider() => const SizedBox(
        width: double.infinity - 50,
        child: Divider(
          height: 20,
        ),
      );

  Widget pubCard(publication) {
    var heightt = MediaQuery.of(context).size.height;
    var widthtt = MediaQuery.of(context).size.width;
    String firstHalf;
    String secondHalf;
    bool isPressed2 = true;
    bool isHighlighted = true;
    List x = publication.likers;
    var id = Provider.of<MyProvider>(context).id.toString();
    bool likes = false;
    for (var i in publication.likers) {
      if (i == id) {
        likes = true;
        break;
      }
    }
    if (publication.content.length > 50) {
      firstHalf = publication.content.substring(0, 50);
      secondHalf =
          publication.content.substring(50, publication.content.length);
    } else {
      firstHalf = publication.content;
      secondHalf = "";
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 3.5),
      child: Card(
        elevation: 10,
        shadowColor: Colors.blueGrey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Column(children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 20, 8, 0),
                child: GlassMorphisme(
                  blur: 1,
                  opacity: 0.1,
                  child: SizedBox(
                    height: heightt * (1 / 14),
                    width: double.infinity - 10,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(120, 15, 0, 15),
                          child: Text(
                            "${publication.user.nom} ${publication.user.prenom}",
                            style: const TextStyle(fontSize: 22),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.cyanAccent,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(2),
            child: SizedBox(
              width: double.infinity,
              height: heightt / 2.3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GlassMorphisme(
                    blur: 1,
                    opacity: 0.1,
                    child: SizedBox(
                      height: heightt / 2.8,
                      width: widthtt / 6.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              likes == false
                                  ? IconButton(
                                      icon: const Icon(
                                        Icons.favorite_rounded,
                                        color: Colors.red,
                                        size: 30,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          x = x + [id];
                                          connection.updatePublicationLike(
                                              publication.id, x);
                                        });
                                      },
                                    )
                                  : IconButton(
                                      icon: const Icon(
                                        Icons.favorite_rounded,
                                        color: Colors.red,
                                        size: 30,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          bool x1 = x.remove(id);
                                          connection.updatePublicationLike(
                                              publication.id, x);
                                        });
                                      },
                                    ),
                              Column(
                                children: [
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      textStyle: const TextStyle(fontSize: 20),
                                    ),
                                    onPressed: () {
                                      pushNewScreen(
                                        context,
                                        screen: RCommentAffich(
                                          id: publication.id,
                                        ),
                                      );
                                    },
                                    child: const Icon(
                                      Icons.comment_rounded,
                                      size: 37,
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                  Text(
                                    "${publication.comments.length}",
                                    style:
                                        TextStyle(color: Colors.grey.shade400),
                                  )
                                ],
                              ),
                            ],
                          ),
                          GlassMorphisme(
                            blur: 1,
                            opacity: 0.1,
                            child: SizedBox(
                              width: widthtt / 1.3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "${publication.titre}",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black.withOpacity(0.7),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(maxLines: 2, "$firstHalf ..."),
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: const [
                                        Text(
                                          "show more",
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                      ],
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: ((context) => DetailPub(
                                                publication: publication,
                                              )),
                                        ),
                                      );
                                    },
                                  ),
                                  publication.img == ""
                                      ? Container()
                                      : Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: SizedBox(
                                              width: widthtt,
                                              height: widthtt / 1.5,
                                              child: FittedBox(
                                                  fit: BoxFit.fill,
                                                  child:
                                                      image(publication.img)),
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
