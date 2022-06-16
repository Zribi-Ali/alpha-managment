import 'dart:async';

import 'package:alpha/Provider/myprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import '../../Connection.dart';
import '../../Models/Evenement.dart';

class EvenementA extends StatefulWidget {
  const EvenementA({super.key});

  @override
  State<EvenementA> createState() => _EvenementAState();
}

Color ep = const Color(0xFF8CCFEC).withOpacity(.8);
Color ce1 = const Color(0xFF033B4C);
Color ce2 = const Color(0xFF1584A1).withOpacity(.8);
Color pp = const Color(0xFF394D5F).withOpacity(.8);
Color cp1 = const Color(0xFF0B1320);
Color cp2 = const Color(0xFFFEF9E6);
List<Color> colors1 = [
  const Color(0xFF014871),
  const Color(0xFF57370D),
  const Color(0xFF353A5F),
  const Color(0xFF333333),
];
List<Color> colors2 = [
  const Color(0xFFD7EDE2),
  const Color(0xFFFFE998),
  const Color(0xFF9EBAF3),
  const Color(0xFF76CCB1),
];

class _EvenementAState extends State<EvenementA> with TickerProviderStateMixin {
  late ScrollController controller;
  final DemoConnection connection = DemoConnection();
  bool _showAppbar = true;
  bool isScrollingDown = false;
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
  }

  @override
  Widget build(BuildContext context) {
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
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              title: const Text(
                'Evenement',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: connection.fetchEvenement(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Evenement>> snapshot) {
                if (snapshot.hasData) {
                  return Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                  //scrollDirection: Axis.horizontal,
                                  key: const PageStorageKey<String>('pageOne'),
                                  controller: controller,
                                  shrinkWrap: true,
                                  itemCount: snapshot.data?.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    // index =(snapshot.data?.length)! - index - 1;
                                    var currentpubliation =
                                        snapshot.data![index];
                                    return Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                      child: card(currentpubliation, index),
                                    );
                                  }),
                            ),
                          ],
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
        ],
      ),
    );
  }

  Widget card(evv, index) {
    String id = Provider.of<MyProvider>(context, listen: false).id;
    var participe = false;
    for (var i = 0; i < evv.participant.length; i++) {
      if (Provider.of<MyProvider>(context).id == evv.participant[i]["_id"]) {
        participe = true;
      }
    }
    return Card(
      color: colors2[index],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 10,
      shadowColor: Colors.black,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .5,
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipOval(
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.network(
                        evv.img,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 60, 0, 0),
                  child: Column(
                    children: [
                      Text(
                        evv.nom,
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .7,
                child: SingleChildScrollView(
                  child: Text(
                    evv.description,
                    style: const TextStyle(
                      fontSize: 18,
                      letterSpacing: 1,
                      wordSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ),
            participe
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 25, 25),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        onPressed: () {
                          connection.unparticipe(evv.id, id);
                          participe = false;
                          setState(() {});
                          setState(() {});
                        },
                        icon: Icon(
                          Icons.bookmark,
                          size: 60,
                          color: Colors.pink.shade600,
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 25, 25),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        onPressed: () {
                          connection.participe(evv.id, id);
                          participe = true;
                          setState(() {});
                          setState(() {});
                        },
                        icon: Icon(
                          Icons.bookmark_border,
                          size: 60,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  /* Widget designe() {
    Size size = MediaQuery.of(context).size;
    return Stack(children: [
      Positioned(
        top: size.height * (animation1.value + .58),
        left: size.width * .21,
        child: CustomPaint(
          painter: MyPainter(50),
        ),
      ),
      Positioned(
        top: size.height * .98,
        left: size.width * .1,
        child: CustomPaint(
          painter: MyPainter(animation4.value - 30),
        ),
      ),
      Positioned(
        top: size.height * .5,
        left: size.width * (animation2.value + 0.5),
        child: CustomPaint(
          painter: MyPainter(30),
        ),
      ),
      Positioned(
        top: size.height * animation3.value,
        left: size.width * (animation1.value + .1),
        child: CustomPaint(
          painter: MyPainter(60),
        ),
      ),
      Positioned(
        top: size.height * .1,
        left: size.width * .8,
        child: CustomPaint(
          painter: MyPainter(animation4.value),
        ),
      ),
    ]);
  }
 */
  Widget card1(evv, index) {
    String id = Provider.of<MyProvider>(context, listen: false).id;
    Size size = MediaQuery.of(context).size;
    var participe = false;
    for (var i = 0; i < evv.participant.length; i++) {
      if (Provider.of<MyProvider>(context).id == evv.participant[i]["_id"]) {
        participe = true;
      }
    }
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      width: MediaQuery.of(context).size.width - 13,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.shade600,
            blurRadius: 4,
            offset: const Offset(4, 8), // Shadow position
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: size.height * .1,
            left: size.width * .8,
            child: CustomPaint(
              painter: MyPainter(130, index),
            ),
          ),
          Positioned(
            top: size.height * .5,
            left: size.width * .3,
            child: CustomPaint(
              painter: MyPainter(80, index),
            ),
          ),
          Positioned(
            top: size.height * .03,
            left: size.width * .15,
            child: CustomPaint(
              painter: MyPainter(70, index),
            ),
          ),
          Positioned(
            top: size.height * .2,
            left: size.width * 0.5,
            child: Container(
              width: 170,
              height: 180,
              margin: const EdgeInsets.fromLTRB(0, 0, 170, 0),
              child: Transform.rotate(
                angle: math.pi * -2.1,
                child: ClipPath(
                  clipper: _MyClipper(),
                  child: Image.network(
                    evv.img,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // child: ClipOval(
              //   child: Material(
              //     child: SizedBox(
              //       height: 170,
              //       width: 165,
              //       child: Image.network(
              //         evv.img,
              //         fit: BoxFit.cover,
              //       ),
              //     ),
              //   ),
              // ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 60, 0, 0),
            child: Column(
              children: [
                Text(
                  evv.nom,
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  evv.description,
                  style: const TextStyle(
                    fontSize: 18,
                    letterSpacing: 1,
                    wordSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          participe
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 25, 25),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      onPressed: () {
                        connection.unparticipe(evv.id, id);
                        participe = false;
                        setState(() {});
                        setState(() {});
                      },
                      icon: Icon(
                        Icons.bookmark,
                        size: 60,
                        color: Colors.pink.shade600,
                      ),
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 25, 25),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      onPressed: () {
                        connection.participe(evv.id, id);
                        participe = true;
                        setState(() {});
                        setState(() {});
                      },
                      icon: Icon(
                        Icons.bookmark_border,
                        size: 60,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

class _MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path
      ..moveTo(size.width / 2, 0) // moving to topCenter 1st, then draw the path
      ..lineTo(size.width, size.height * .25)
      ..lineTo(size.width, size.height * .75)
      ..lineTo(size.width * .5, size.height)
      ..lineTo(0, size.height * .75)
      ..lineTo(0, size.height * .25)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class MyPainter extends CustomPainter {
  final double radius;
  final int index;

  MyPainter(this.radius, this.index);

  @override
  void paint(Canvas canvas, Size size) {
    int c;
    if (index % 4 == 0) {
      c = 0;
    } else if (index % 4 == 1) {
      c = 1;
    } else if (index % 4 == 2) {
      c = 2;
    } else {
      c = 3;
    }
    final paint = Paint()
      ..shader = LinearGradient(
              colors: [colors1[c], colors2[c]],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight)
          .createShader(
        Rect.fromCircle(
          center: const Offset(0, 0),
          radius: radius,
        ),
      );

    canvas.drawCircle(Offset.zero, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
