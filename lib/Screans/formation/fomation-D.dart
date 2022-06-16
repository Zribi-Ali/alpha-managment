import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../Models/Formation.dart';

class FormationD extends StatefulWidget {
  final formation;
  const FormationD({required Formation this.formation});

  @override
  State<FormationD> createState() => _FormationDState();
}

class _FormationDState extends State<FormationD> with TickerProviderStateMixin {
  late Animation<double> animation1;
  late Animation<double> animation2;
  late Animation<double> animation3;
  late Animation<double> animation4;
  late AnimationController controller1;
  late AnimationController controller2;
  @override
  void initState() {
    super.initState();

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

    animation4 = Tween<double>(begin: 10, end: 30).animate(
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
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .88,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: const Color.fromARGB(255, 246, 210, 210),
            elevation: 22,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: -30,
                  left: -18,
                  child: ClipPath(
                    clipper: _MyClipper(),
                    child: SizedBox(
                      height: 200,
                      width: 180,
                      child: Image.asset("images/logo.png"),
                    ),
                  ),
                ),
                Positioned(
                  top: size.height * .0,
                  left: size.width * .45,
                  child: ClipOval(
                    child: Material(
                      child: SizedBox(
                        height: 300,
                        width: 300,
                        child: Image.asset(
                          "images/formation-amélioration.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: size.height * .35,
                  left: size.width * .56,
                  child: ClipPath(
                    clipper: _MyClipper(),
                    child: Image.network(
                      widget.formation.img,
                      fit: BoxFit.fill,
                      height: 150,
                      width: 135,
                    ),
                  ),
                ),
                Positioned(
                  top: size.height / 4,
                  left: size.width * .03,
                  child: SizedBox(
                    height: 200,
                    width: 180,
                    child: Text(
                      "${widget.formation.nom}",
                      style: const TextStyle(fontSize: 25),
                    ),
                  ),
                ),
                Positioned(
                  top: size.height * 0.6,
                  left: size.width * .7,
                  child: Transform.rotate(
                    angle: math.pi / -10,
                    child: ClipPath(
                      clipper: _MyClipper(),
                      child: Container(
                        height: 120,
                        width: 100,
                        color: Color.fromARGB(255, 255, 255, 255),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${widget.formation.type}",
                              style: const TextStyle(
                                  fontSize: 28, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: size.height * .69,
                  left: size.width * .4,
                  child: Transform.rotate(
                    angle: math.pi,
                    child: RotationTransition(
                      turns: animation3,
                      child: ClipPath(
                        clipper: _MyClipper(),
                        child: Container(
                          height: 120,
                          width: 100,
                          color: Colors.yellow.shade600,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                widget.formation.datedebut,
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                              Container(
                                color: Colors.white,
                                height: 3,
                                width: 50,
                              ),
                              Text(
                                widget.formation.datefin,
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: size.height * .6,
                  left: size.width * .05,
                  child: Transform.rotate(
                    angle: math.pi,
                    child: RotationTransition(
                      turns: animation3,
                      child: ClipPath(
                        clipper: _MyClipper(),
                        child: Container(
                          height: 120,
                          width: 100,
                          color: Colors.red.shade300,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                widget.formation.prix,
                                style: const TextStyle(
                                    fontSize: 40, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: size.height * .38,
                  left: 15,
                  child: Column(
                    children: [
                      SizedBox(
                        width: size.width * .6,
                        child: Text(
                          widget.formation.description,
                          style: const TextStyle(
                              fontSize: 13, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final double radius;

  MyPainter(this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = const LinearGradient(
              colors: [Colors.red, Colors.white],
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
/* child: Transform.rotate(
                    angle: math.pi / -4,
                    child: ClipPath(
                      clipper: _MyClipper(),
                      child: Container(
                        height: 100,
                        color: Colors.amber,
                        width: 100,
                      ),
                    ),
                    RotationTransition(
                    turns: animation2,),
                  ), */