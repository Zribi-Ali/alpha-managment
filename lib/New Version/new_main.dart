import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:alpha/New%20Version/placeGtaggerd.dart';
import 'package:alpha/Provider/myprovider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../Routes.dart';
import '../Screans/Profile/image.dart';
import 'image.dart';

class NewMain extends StatefulWidget {
  const NewMain({Key? key}) : super(key: key);

  @override
  State<NewMain> createState() => _NewMainState();
}

Color ep = Color(0xFFFCF4EC).withOpacity(.8);
Color ce1 = Color(0xFFFF9F97);
Color ce2 = Color(0xFF65B6EC).withOpacity(.8);
Color pp = Color(0xFFdde8f0);
Color cp1 = Color(0xFF001b48);
Color cp2 = Color(0xFF97cdbc);

class _NewMainState extends State<NewMain> with TickerProviderStateMixin {
  late AnimationController controller1;
  late AnimationController controller2;
  late Animation<double> animation1;
  late Animation<double> animation2;
  late Animation<double> animation3;
  late Animation<double> animation4;

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
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String address = Provider.of<MyProvider>(context).addressip;
    var imag = Provider.of<MyProvider>(context).image;
    String role = Provider.of<MyProvider>(context).role;
    return Scaffold(
      backgroundColor: role == "etudiant" ? ep : pp,
      body: Stack(
        children: [
          Positioned(
            top: size.height * (animation2.value + .58),
            left: size.width * .21,
            child: CustomPaint(
              painter: MyPainter(50, role),
            ),
          ),
          Positioned(
            top: size.height * .98,
            left: size.width * .1,
            child: CustomPaint(
              painter: MyPainter(animation4.value - 30, role),
            ),
          ),
          Positioned(
            top: size.height * .5,
            left: size.width * (animation2.value + 0.5),
            child: CustomPaint(
              painter: MyPainter(30, role),
            ),
          ),
          Positioned(
            top: size.height * animation3.value,
            left: size.width * (animation1.value + .1),
            child: CustomPaint(
              painter: MyPainter(60, role),
            ),
          ),
          Positioned(
            top: size.height * .1,
            left: size.width * .8,
            child: CustomPaint(
              painter: MyPainter(animation4.value, role),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 10, 50, 5),
                    child: ClipOval(
                      child: Material(
                        child: SizedBox(
                          height: 70,
                          width: 70,
                          child: Image.network(
                            imag,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 50),
                    child: Text(
                      "${Provider.of<MyProvider>(context).nom}  ${Provider.of<MyProvider>(context).prenom}",
                      style: const TextStyle(fontSize: 28, color: Colors.black),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(RouteManager.loginPage);
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.rightFromBracket,
                      size: 22,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              Text(
                role,
                style: TextStyle(
                    color: Colors.blueGrey.shade400,
                    fontSize: 18,
                    letterSpacing: 1),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: PlaceStoggerdGridView(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildImage(imag) {
    return ClipOval(
      child: Material(
        // color: Colors.transparent,
        child: SizedBox(
          height: 100,
          width: 100,
          child: image(imag),
        ),
      ),
    );
  }
}

Widget image(String img) {
  final _byteImage = const Base64Decoder().convert(img);
  return Image.memory(_byteImage);
}

class MyPainter extends CustomPainter {
  final double radius;
  String role;

  MyPainter(this.radius, this.role);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
              colors: role == "etudiant" ? [ce1, ce2] : [cp1, cp2],
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
