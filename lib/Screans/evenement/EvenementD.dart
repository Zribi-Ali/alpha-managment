import 'dart:async';

import 'package:flutter/material.dart';

class wCardEvenement extends StatefulWidget {
  final evenement;
  final int index;
  const wCardEvenement(
      {super.key, required this.index, required this.evenement});

  @override
  State<wCardEvenement> createState() => _WEVEState();
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

class _WEVEState extends State<wCardEvenement> with TickerProviderStateMixin {
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
    return SizedBox(
      height: MediaQuery.of(context).size.height * .88,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: card(),
      ),
    );
  }

  Widget card() {
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
                  painter: MyPainter(280, widget.index),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.evenement.nom),
                    SizedBox(
                      height: 18,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .45,
                      child: Text(widget.evenement.description),
                    ),
                    Text(widget.evenement.date),
                    Text(widget.evenement.prix),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: size.height * 0,
            left: size.width * (animation2.value + 1),
            child: CustomPaint(
              painter: MyPainter(200, widget.index),
            ),
          ),
          Positioned(
            top: size.height * .45,
            left: size.width * (animation2.value + 1),
            child: Stack(
              children: [
                CustomPaint(
                  painter: MyPainter(210, widget.index),
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

class Even extends StatefulWidget {
  final evenement;
  final int index;
  const Even({super.key, required this.evenement, required this.index});

  @override
  State<Even> createState() => _EvenState();
}

class _EvenState extends State<Even> with TickerProviderStateMixin {
  late Animation<double> animation1;
  late Animation<double> animation2;
  late Animation<double> animation3;
  late Animation<double> animation4;
  late AnimationController controller1;
  late AnimationController controller2;
  late Timer time;
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
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .88,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: card(),
        ),
      ),
    );
  }

  Widget card() {
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
                  painter: MyPainter(280, widget.index),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.evenement.nom),
                    SizedBox(
                      height: 18,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .45,
                      child: Text(widget.evenement.description),
                    ),
                    Text(widget.evenement.date),
                    Text(widget.evenement.prix),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: size.height * 0,
            left: size.width * (animation2.value + 1),
            child: CustomPaint(
              painter: MyPainter(200, widget.index),
            ),
          ),
          Positioned(
            top: size.height * .45,
            left: size.width * (animation2.value + 1),
            child: Stack(
              children: [
                CustomPaint(
                  painter: MyPainter(210, widget.index),
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
