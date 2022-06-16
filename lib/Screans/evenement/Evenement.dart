import 'dart:async';

import 'package:alpha/Provider/myprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import '../../Connection.dart';
import '../../Models/Evenement.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'EvenementD.dart';

class EvenementAff extends StatefulWidget {
  const EvenementAff({Key? key}) : super(key: key);

  @override
  State<EvenementAff> createState() => _EvenementState();
}

Color ep = const Color(0xFF8CCFEC).withOpacity(.8);
Color ce1 = const Color(0xFF033B4C);
Color ce2 = const Color(0xFF1584A1).withOpacity(.8);
Color pp = const Color(0xFF394D5F).withOpacity(.8);
Color cp1 = const Color(0xFF0B1320);
Color cp2 = const Color(0xFFFEF9E6);

class _EvenementState extends State<EvenementAff>
    with TickerProviderStateMixin {
  final DemoConnection connection = DemoConnection();
  late ScrollController controller;
  late AnimationController controller1;
  late AnimationController controller2;
  late Animation<double> animation1;
  late Animation<double> animation2;
  late Animation<double> animation3;
  late Animation<double> animation4;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
    controller1 = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 5,
      ),
    );
    animation1 = Tween<double>(begin: .1, end: .15).animate(
      CurvedAnimation(
        parent: controller1,
        curve: Curves.easeInOut,
      ),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller1.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller1.forward();
        }
      });
    animation2 = Tween<double>(begin: .02, end: .04).animate(
      CurvedAnimation(
        parent: controller1,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
        setState(() {});
      });

    controller2 = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 5,
      ),
    );
    animation3 = Tween<double>(begin: .41, end: .38).animate(CurvedAnimation(
      parent: controller2,
      curve: Curves.easeInOut,
    ))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller2.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller2.forward();
        }
      });
    animation4 = Tween<double>(begin: 170, end: 190).animate(
      CurvedAnimation(
        parent: controller2,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
        setState(() {});
      });

    Timer(const Duration(milliseconds: 2500), () {
      controller1.forward();
    });

    controller2.forward();
  }

  @override
  void dispose() {
    controller = ScrollController();
    controller.dispose();
    controller.removeListener(() {});
    super.dispose();
    //context.read<MyProvider>().cotroller;
  }

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
  Random random = Random();
  var c;
  @override
  Widget build(BuildContext context) {
    var id = Provider.of<MyProvider>(context).id;
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
                        child: RefreshIndicator(
                          onRefresh: _refresh,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              controller: controller,
                              shrinkWrap: true,
                              itemCount: snapshot.data?.length,
                              itemBuilder: (BuildContext context, int index) {
                                var currentevenement = snapshot.data![index];
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 9),
                                  child: Column(
                                    children: [
                                      Center(
                                        child: Text("${currentevenement.nom}"),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ),
                    ],
                  );
                }
                if (snapshot.hasError) {
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

  Widget designe() {
    Size size = MediaQuery.of(context).size;
    return Stack(children: [
      Positioned(
        top: size.height * (animation2.value + .58),
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

  Widget card1(evv) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          designe(),
          Center(
            child: Column(
              children: [
                Text(
                  evv.nom,
                  style: const TextStyle(fontSize: 20),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget card(evenement, index) {
    Size size = MediaQuery.of(context).size;
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Colors.white,
      elevation: 22,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -30,
            left: 0,
            child: SizedBox(
              height: 150,
              width: 150,
              child: Image.asset("images/logo.png"),
            ),
          ),
          Positioned(
            top: size.height * .5,
            left: size.width * (animation2.value),
            child: Stack(
              alignment: AlignmentDirectional.centerStart,
              children: [
                CustomPaint(
                  painter: MyPainter(280),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(evenement.nom),
                    const SizedBox(
                      height: 18,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .45,
                      child: Text(evenement.description),
                    ),
                    Text(evenement.date),
                    Text(evenement.prix),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: size.height * 0,
            left: size.width * (animation2.value + 1),
            child: CustomPaint(
              painter: MyPainter(200),
            ),
          ),
          Positioned(
            top: size.height * .45,
            left: size.width * (animation2.value + 1),
            child: Stack(
              children: [
                CustomPaint(
                  painter: MyPainter(210),
                ),
                // Text("data"),
              ],
            ),
          ),
          Positioned(
            top: size.height * .2,
            left: size.width * .48,
            child: ClipOval(
              child: Material(
                child: SizedBox(
                  height: 400,
                  width: 400,
                  child: Image.asset(
                    "images/formation-amélioration.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> _refresh() {
  return Future.delayed(
    const Duration(seconds: 1),
  );
}

/*   Widget eventCard(data, index, id) {var c;
    if (index % 4 == 0) {
      c = 0;
    } else if (index % 4 == 1) {
      c = 1;
    } else if (index % 4 == 2) {
      c = 2;
    } else {
      c = 3;
    }

    List part = data.participant;
    var particip = false;
    for (var i in data.participant) {
      if (i == id) {
        particip = true;
        break;
      }
    }
    
    return Container(
      margin: const EdgeInsets.fromLTRB(5, 22, 5, 22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            colors1[c],
            colors2[c],
          ],
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade600,
            offset: const Offset(20.0, 8.0), //(x,y)
            blurRadius: 26.0,
          ),
        ],
        //color: Colors.pink,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(80),
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2.3,
                height: MediaQuery.of(context).size.width / 1.5,
                child: const FlutterLogo(
                  size: 30,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 5, 10),
            child: Align(
              alignment: Alignment.topRight,
              child: Column(
                children: [
                  ClipOval(
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: Image.network(
                        'https://www.industrialempathy.com/img/remote/ZiClJf-1920w.jpg',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    "${data.nom}",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${data.description}",
                    style: const TextStyle(
                      fontSize: 10,
                      wordSpacing: 1,
                    ),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Text(
                    "Time 15:30",
                    style: TextStyle(
                        fontSize: 22,
                        wordSpacing: 1,
                        color: Colors.cyan.shade900),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Text(
                    "Prix : 70D",
                    style: TextStyle(
                      fontSize: 22,
                      wordSpacing: 1,
                      color: Colors.red.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: particip == false
                  ? IconButton(
                      icon: const Icon(
                        Icons.bookmark,
                        color: Colors.grey,
                        size: 60.0,
                      ),
                      onPressed: () {
                        setState(() {
                          part = part + [id];
                          print(id);
                          connection.updatePublicationLike(data.id, part);
                        });
                      },
                    )
                  : IconButton(
                      icon: Icon(
                        Icons.bookmark,
                        color: Colors.yellowAccent.shade700,
                        size: 60.0,
                      ),
                      onPressed: () {
                        setState(() {
                          bool x1 = part.remove(id);
                          connection.updatePublicationLike(data.id, part);
                        });
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
 */
Widget CardEvenement(Evenement data) {
  return Card(
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
        Text(
          "${data.nom}",
          style: const TextStyle(
              fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.teal),
        ),
        const SizedBox(
          height: 20.0,
        ),
        Text(
          "${data.img}",
          style: const TextStyle(
              fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.teal),
        ),
        const SizedBox(
          height: 20.0,
        ),
        Text(
          "${data.description}",
          style: const TextStyle(
              fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.teal),
        ),
        const SizedBox(
          height: 20.0,
        ),
      ],
    ),
  );
}

class MyPainter extends CustomPainter {
  final double radius;

  MyPainter(this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
              colors: [cp1, cp2],
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
