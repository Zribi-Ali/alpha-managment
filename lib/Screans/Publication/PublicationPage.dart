// ignore_for_file: dead_code

import 'dart:convert';

import 'package:alpha/Provider/myprovider.dart';
import 'package:alpha/Screans/Publication/modifier_pub.dart';
import 'package:flutter/rendering.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import '../../Connection.dart';
import '../../Models/Comment.dart';
import '../../Models/Publication.dart';
import 'package:flutter/material.dart';
import '../../New Version/new_main.dart';
import '../CommentPage.dart';
import '../RCommentPage.dart';
import 'addpublication.dart';
import 'detaill_Publication.dart';

final bucketGlobal = PageStorageBucket();

class AffichPublication extends StatefulWidget {
  const AffichPublication({Key? key}) : super(key: key);

  @override
  State<AffichPublication> createState() => _AffichPublicationState();
}

class _AffichPublicationState extends State<AffichPublication> {
  final DemoConnection connection = DemoConnection();

  late ScrollController controller;

  bool _showAppbar = true;
  bool isScrollingDown = false;
/*   @override
  void initState() {
    super.initState();
    controller = ScrollController();
  
  controller.addListener(() {
    if (controller.position.userScrollDirection == ScrollDirection.reverse) {
      if (!isScrollingDown) {
        isScrollingDown = true;
        _showAppbar = false;
        setState(() {});
      }}
      if (controller.position.userScrollDirection == ScrollDirection.forward) {
      if (isScrollingDown) {
        isScrollingDown = false;
        _showAppbar = true;
        setState(() {});
      }
    
  }
    //context.read<MyProvider>().cotroller;
  }
 */
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
  }

  @override
  void dispose() {
    controller = ScrollController();
    controller.dispose();
    controller.removeListener(() {});
    super.dispose();
    //context.read<MyProvider>().cotroller;
  }

  @override
  Widget build(BuildContext context) {
    var _id = Provider.of<MyProvider>(context).id.toString();
    return Scaffold(
      body: Column(
        children: [
          AnimatedContainer(
            height: _showAppbar ? 100.0 : 0.0,
            duration: const Duration(milliseconds: 400),
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const NewMain()));
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              title: const Text(
                'Publication',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          Expanded(
            child: PageStorage(
              bucket: bucketGlobal,
              child: FutureBuilder(
                future: connection.fetchPubliucation(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Publiucation>> snapshot) {
                  if (snapshot.hasData) {
                    return Row(
                      children: [
                        Expanded(
                          child: RefreshIndicator(
                            displacement: 100,
                            edgeOffset: 10,
                            strokeWidth: 3,
                            color: Colors.teal,
                            onRefresh: _refresh,
                            child: Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                      key: const PageStorageKey<String>(
                                          'pageOne'),
                                      controller: controller,
                                      shrinkWrap: true,
                                      itemCount: snapshot.data?.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        index = (snapshot.data?.length)! -
                                            index -
                                            1;
                                        var currentpubliation =
                                            snapshot.data![index];
                                        return SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              1.5,
                                          width: double.infinity,
                                          child: pub(currentpubliation,
                                              currentpubliation.comments),
                                        );
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }

                  if (snapshot.hasError) {
                    print("${snapshot.error} ******");
                    return const Center(
                      child: Icon(
                        Icons.error,
                        color: Colors.red,
                        size: 82.0,
                      ),
                    );
                  }

                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text("Chargement en cours ...")
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),

      /* floatingActionButton: FloatingActionButton.extended(
          icon: const Icon(
            Icons.border_color_sharp,
            size: 14,
          ),
          onPressed: () {
            setState(() {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddPublication(
                    id: _id,
                  ),
                ),
              );
            });
          },
          backgroundColor: Colors.teal,
          label: const Text(
            "ajouter publication",
            style: TextStyle(fontSize: 11, letterSpacing: 1.0),
          )), */
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.teal,
        onPressed: () {
          pushNewScreen(
            context,
            screen: const AddPublication(),
            withNavBar: false,
          );
        },
        label: const Text(
          "New Publication",
          style: const TextStyle(fontSize: 10.0),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }

  Future<void> _refresh() {
    return Future.delayed(
      const Duration(seconds: 1),
    );
  }

  Widget pub(publication, tab) {
    var nblike = publication.likers.length - 1;

    List x = publication.likers;
    var id = Provider.of<MyProvider>(context).id.toString();
    String firstHalf;
    String secondHalf;
    bool user;

    bool flag = true;
    bool likes = false;
    for (var i in publication.likers) {
      if (i == id) {
        likes = true;
        break;
      }
    }
    if (Provider.of<MyProvider>(context).id == publication.user.id) {
      user = true;
    } else {
      user = false;
    }
    if (publication.content.length > 50) {
      firstHalf = publication.content.substring(0, 50);
      secondHalf =
          publication.content.substring(50, publication.content.length);
    } else {
      firstHalf = publication.content;
      secondHalf = "";
    }

    String w = "";

    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailPub(
                  publication: publication,
                )),
      ),
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
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://images.unsplash.com/photo-1541963463532-d68292c34b19?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8&w=1000&q=80"),
                      radius: 30.0,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "${publication.nom}",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black.withOpacity(0.7),
                      ),
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
                                      ));
                                },
                                icon: Icon(Icons.menu_open_sharp),
                              ),
                              IconButton(
                                onPressed: () {
                                  connection.deletePublication(publication.id);
                                  setState(() {});
                                },
                                icon: Icon(Icons.delete),
                              ),
                            ],
                          )
                        : Container()
                  ],
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Divider(
                color: Colors.grey.shade400,
                thickness: 1,
              ),
              /* Align(
                alignment: Alignment.topRight,
                child: time(publication),
              ), */
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
              /*  InkWell(
                onTap: () {
                  
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text(
                      "show more",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
              ), */

              /*  Text(
                "${publication.content}",
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black.withOpacity(0.7),
                ),
              ), */
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.black.withOpacity(0.1),
                  height: MediaQuery.of(context).size.height * 0.28,
                  width: double.infinity - 20,
                  child: image(publication.img),
                ),
              ),
              Divider(
                color: Colors.grey.shade400,
                thickness: 1,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: likes == false
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
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
                                  setState(() {
                                    bool x1 = x.remove(id);
                                    connection.updatePublicationLike(
                                        publication.id, x);
                                  });
                                },
                              ),
                              Text(
                                "vous et ${nblike}",
                                style: TextStyle(color: Colors.grey.shade400),
                              )
                            ],
                          ),
                  ),
                  Expanded(
                    child: Row(
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
                          child: const Text('Commentair'),
                        ),
                        Text(
                          "${publication.comments.length}",
                          style: TextStyle(color: Colors.grey.shade400),
                        )
                      ],
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

  // Widget buildImage(Publiucation p) {
  //   return Container(
  //     child: Image.memory(
  //       base64Decode(p.img),
  //     ),
  //   );
  // }

  Widget buildImage(String url) => Padding(
        padding: EdgeInsets.all(5.0),
        child: Image.network(
          url,
          fit: BoxFit.cover,
          width: double.infinity,
          height: MediaQuery.of(context).size.width,
        ),
      );

  Widget image(String thumbnail) {
    final _byteImage = Base64Decoder().convert(thumbnail);
    Widget image = Image.memory(_byteImage);
    return image;
  }

  Widget buildDivider() => Container(
        child: const Divider(
          height: 20,
        ),
        width: double.infinity - 50,
      );

  Widget time(data) {
    var d = DateTime.now().hour - DateTime.parse(data.createdAt).hour;

    String w = "";

    /* if ((((DateTime.now().second - DateTime.parse(data.createdAt).second))
                .abs() <
            59) &
        (((DateTime.now().minute - DateTime.parse(data.createdAt).minute))
                .abs() <
            1)) {
      w = "${(DateTime.now().second - DateTime.parse(data.createdAt).second)} *S";
    } else if ((((DateTime.now().minute -
                    DateTime.parse(data.createdAt).minute))
                .abs() <
            59) &
        (((DateTime.now().hour - DateTime.parse(data.createdAt).hour)).abs() <
            1) &
        (((DateTime.now().day - DateTime.parse(data.createdAt).day)).abs() <
            1)) {
      w = "${(DateTime.now().minute - DateTime.parse(data.createdAt).month)} * Mo";
    } else if ((((DateTime.now().hour - DateTime.parse(data.createdAt).hour))
                .abs() <
            23) &
        (((DateTime.now().day - DateTime.parse(data.createdAt).day)).abs() <
            1)) {
      w = "${(DateTime.now().hour - DateTime.parse(data.createdAt).hour)} *H";
    } else if ((((DateTime.now().day - DateTime.parse(data.createdAt).day))
            .abs() <
        31)) {
      w = "${(DateTime.now().day - DateTime.parse(data.createdAt).day)} *J";
    } else if (((DateTime.now().month - DateTime.parse(data.createdAt).month))
            .abs() >
        1) {
      w = "${(DateTime.now().month - DateTime.parse(data.createdAt).month)} *M";
    } else if (((DateTime.now().year - DateTime.parse(data.createdAt).year))
            .abs() >
        1) {
      w = "${(DateTime.now().year - DateTime.parse(data.createdAt).year)} *Y";
    }
 */

    if ((((DateTime.now().year - DateTime.parse(data.createdAt).year)).abs() >
        1)) {
      w = "${(DateTime.now().year - DateTime.parse(data.createdAt).year)} *Y";
    } else if ((((DateTime.now().month - DateTime.parse(data.createdAt).month))
            .abs() ==
        (1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12))) {
      w = "${(DateTime.now().month - DateTime.parse(data.createdAt).month).abs()} *Mo";
      print("${DateTime.now().month}" +
          " ** ${DateTime.parse(data.createdAt).month} mon ${data.content}");
    } else if ((((DateTime.now().day - DateTime.parse(data.createdAt).day))
                .abs() <
            31) &
        (((DateTime.now().hour - 2 - DateTime.parse(data.createdAt).hour))
                .abs() <
            23)) {
      w = "${(DateTime.now().day - DateTime.parse(data.createdAt).day)} *J";
      print("${DateTime.now().day}" +
          " ** ${DateTime.parse(data.createdAt).day} jj ${data.content}");
    }
    if ((((DateTime.now().hour - DateTime.parse(data.createdAt).hour)).abs() <
            23) &
        (((DateTime.now().minute - DateTime.parse(data.createdAt).minute))
                .abs() <
            59) &
        (((DateTime.now().minute -
                    DateTime.parse(data.createdAt).minute))
                .abs() <
            59) &
        (((DateTime.now().day - DateTime.parse(data.createdAt).day)).abs() <
            1) &
        (((DateTime.now().month - DateTime.parse(data.createdAt).month)).abs() <
            1) &
        (((DateTime.now().year - DateTime.parse(data.createdAt).year)).abs() <
            1)) {
      w = "${(DateTime.now().hour - DateTime.parse(data.createdAt).hour).abs()} *H";
      print("${DateTime.now().hour}" +
          " ** ${DateTime.parse(data.createdAt).hour} hh ${data.content}");
    }
    if ((((DateTime.now().minute - DateTime.parse(data.createdAt).minute))
                .abs() <
            59) &
        (((DateTime.now().hour - DateTime.parse(data.createdAt).hour)).abs() <
            1) &
        (((DateTime.now().day - DateTime.parse(data.createdAt).day)).abs() <
            1) &
        (((DateTime.now().month - DateTime.parse(data.createdAt).month)).abs() <
            1) &
        (((DateTime.now().year - DateTime.parse(data.createdAt).year)).abs() <
            1)) {
      w = "${(DateTime.now().minute - DateTime.parse(data.createdAt).minute).abs()} *Mi";
      print("${DateTime.now().minute}" +
          " ** ${DateTime.parse(data.createdAt).minute} min ${data.content}");
    } else if ((((DateTime.now().second -
                    DateTime.parse(data.createdAt).second))
                .abs() <
            59) &
        (((DateTime.now().minute -
                    DateTime.parse(data.createdAt).minute))
                .abs() <
            1) &
        (((DateTime.now().hour -
                    1 -
                    DateTime.parse(data.createdAt).hour))
                .abs() <
            1) &
        (((DateTime.now().day - DateTime.parse(data.createdAt).day))
                .abs() <
            1) &
        (((DateTime.now().month - DateTime.parse(data.createdAt).month)).abs() <
            1) &
        (((DateTime.now().year - DateTime.parse(data.createdAt).year)).abs() <
            1)) {
      w = "${(DateTime.now().second - DateTime.parse(data.createdAt).second).abs()} *S";
      print("${DateTime.now().second}" +
          " ** ${DateTime.parse(data.createdAt).second} se ${data.content}");
    }

    return Container(
        child: Text(
      w,
      style: const TextStyle(fontSize: 10, color: Colors.red),
    ));
  }
}



/*
 return Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      elevation: 10.0,
                                      shadowColor: Colors.black,
                                      color: Colors.white70,
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 20.0,
                                          ),
                                          //   pub(currentpubliation),
                                          Text(
                                              " titre   :${currentpubliation.titre}"),
                                          const SizedBox(
                                            height: 20.0,
                                          ),
                                          Text(
                                              " nom    :${currentpubliation.nom}"),
                                          const SizedBox(
                                            height: 20.0,
                                          ),
                                          Text(
                                              " content :${currentpubliation.content}"),
                                          const SizedBox(
                                            height: 20.0,
                                          ),
                                          Center(
                                            child: Text(
                                              " id    :${currentpubliation.id}",
                                              style: const TextStyle(
                                                  color: Colors.redAccent),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20.0,
                                          ),
                                          // getTextWidgets(tab),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SizedBox(
                                                  height: 40,
                                                  width: 100,
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                      textStyle:
                                                          MaterialStateProperty
                                                              .all(
                                                        const TextStyle(
                                                            fontSize: 10.0),
                                                      ),
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(Colors
                                                                  .white60),
                                                      foregroundColor:
                                                          MaterialStateProperty
                                                              .all(Colors.blue
                                                                  .shade400),
                                                      overlayColor:
                                                          MaterialStateProperty
                                                              .all(Colors.blue
                                                                  .shade50),
                                                      shadowColor:
                                                          MaterialStateProperty
                                                              .all(
                                                                  Colors.black),
                                                      elevation:
                                                          MaterialStateProperty
                                                              .all(15),
                                                      padding:
                                                          MaterialStateProperty
                                                              .all(
                                                                  const EdgeInsets
                                                                          .all(
                                                                      9.0)),
                                                      shape:
                                                          MaterialStateProperty
                                                              .all(
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      x++;
                                                      setState(() {});
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .thumb_up_alt_outlined,
                                                          size: 25.0,
                                                          color: Colors
                                                              .blue.shade400,
                                                        ),
                                                        Text(
                                                          "$x",
                                                          style: TextStyle(
                                                              color: Colors.blue
                                                                  .shade400,
                                                              fontSize: 20.0),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SizedBox(
                                                  height: 40,
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                      textStyle:
                                                          MaterialStateProperty
                                                              .all(
                                                        const TextStyle(
                                                            fontSize: 5.0),
                                                      ),
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(Colors
                                                                  .white60),
                                                      foregroundColor:
                                                          MaterialStateProperty
                                                              .all(Colors.blue
                                                                  .shade400),
                                                      overlayColor:
                                                          MaterialStateProperty
                                                              .all(Colors.blue
                                                                  .shade50),
                                                      shadowColor:
                                                          MaterialStateProperty
                                                              .all(
                                                                  Colors.black),
                                                      elevation:
                                                          MaterialStateProperty
                                                              .all(15),
                                                      padding:
                                                          MaterialStateProperty
                                                              .all(
                                                                  const EdgeInsets
                                                                          .all(
                                                                      7.0)),
                                                      shape:
                                                          MaterialStateProperty
                                                              .all(
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      pushNewScreen(
                                                        context,
                                                        screen: CommentesAff(
                                                            listcommentair: tab,
                                                            id_publication:
                                                                "${currentpubliation.id}"),
                                                        withNavBar: false,
                                                      );
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.comment,
                                                          size: 18.0,
                                                          color: Colors
                                                              .blue.shade400,
                                                        ),
                                                        Text(
                                                          "Comment",
                                                          style: TextStyle(
                                                              color: Colors.blue
                                                                  .shade400,
                                                              fontSize: 20.0),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
 */