import 'dart:async';

import 'package:alpha/Models/Formation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;

import '../../Connection.dart';
import '../../Models/Evenement.dart';

class FormationA extends StatefulWidget {
  const FormationA({super.key});

  @override
  State<FormationA> createState() => _EvenementAState();
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
List<Color> colors3 = [
  const Color(0xFFB6DCB6),
  const Color(0xFFFBEFC9),
  const Color(0xFFF8DDA9),
  const Color(0xFFD4F4EC),
];

class _EvenementAState extends State<FormationA> with TickerProviderStateMixin {
  late ScrollController controller;
  final DemoConnection connection = DemoConnection();
  @override
  void initState() {
    super.initState();
    controller = ScrollController();
  }

  @override
  void dispose() {
    controller = ScrollController();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AnimatedContainer(
            height: 100.0,
            duration: const Duration(milliseconds: 400),
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                ),
              ),
              title: const Center(
                child: Text(
                  'Formation',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: connection.fetchFormation(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Formation>> snapshot) {
                if (snapshot.hasData) {
                  return Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  key: const PageStorageKey<String>('pageOne'),
                                  controller: controller,
                                  shrinkWrap: true,
                                  itemCount: snapshot.data?.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    index =
                                        (snapshot.data?.length)! - index - 1;
                                    var currentformation =
                                        snapshot.data![index];
                                    return Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          4, 3, 4, 12),
                                      child: card1(currentformation, index),
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
  Widget card1(form, index) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: colors3[index],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 20,
        shadowColor: Colors.black,
        child: SizedBox(
          height: size.height * .7,
          width: size.width * .9,
          child: Stack(
            children: [
              Positioned(
                top: size.height * .2,
                left: size.width * .3,
                child: CustomPaint(
                  painter: MyPainter(20, index),
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
                top: size.height * .22,
                left: size.width * 0.65,
                child: CustomPaint(
                  painter: MyPainter(100, index),
                ),
              ),
              Positioned(
                top: size.height * .11,
                left: size.width * 0.41,
                child: SizedBox(
                  width: 180,
                  height: 180,
                  child: ClipOval(
                    child: Material(
                      child: Image.network(
                        form.img,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 60, 0, 0),
                child: Column(
                  children: [
                    Text(
                      form.nom,
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 200, 4, 4),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * .7,
                  height: MediaQuery.of(context).size.height * .9,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        form.description,
                        style: const TextStyle(
                          fontSize: 18,
                          letterSpacing: 1,
                          wordSpacing: 0.5,
                        ),
                      ),
                      Row(
                        children: [
                          const Text(
                            "Type de formation  : ",
                            style: TextStyle(
                              fontSize: 15,
                              letterSpacing: 1,
                              wordSpacing: 0.5,
                            ),
                          ),
                          Text(
                            "${form.type}",
                            style: const TextStyle(
                              fontSize: 18,
                              letterSpacing: 1,
                              wordSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        form.duree,
                        style: const TextStyle(
                          fontSize: 18,
                          letterSpacing: 1,
                          wordSpacing: 0.5,
                        ),
                      ),
                      Row(
                        children: [
                          const Text(
                            "Début en : ",
                            style: TextStyle(
                              fontSize: 15,
                              letterSpacing: 1,
                              wordSpacing: 0.5,
                            ),
                          ),
                          Text(
                            "${form.datedebut}",
                            style: const TextStyle(
                              fontSize: 18,
                              letterSpacing: 1,
                              wordSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            "Terminer en : ",
                            style: TextStyle(
                              fontSize: 15,
                              letterSpacing: 1,
                              wordSpacing: 0.5,
                            ),
                          ),
                          Text(
                            "${form.datefin}",
                            style: const TextStyle(
                              fontSize: 18,
                              letterSpacing: 1,
                              wordSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            "Le prix : ",
                            style: TextStyle(
                              fontSize: 15,
                              letterSpacing: 1,
                              wordSpacing: 0.5,
                            ),
                          ),
                          Text(
                            "${form.prix}",
                            style: const TextStyle(
                              fontSize: 18,
                              letterSpacing: 1,
                              wordSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
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
