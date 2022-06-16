import 'dart:ui';
import 'package:flutter/material.dart';

Color cp1 = Color(0xFF13424c);
Color cp2 = Colors.blueGrey;

class GlassMorphisme extends StatelessWidget {
  final double blur;
  final double opacity;
  final Widget child;

  const GlassMorphisme({
    Key? key,
    required this.blur,
    required this.opacity,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                cp1.withOpacity(.3),
                cp2.withOpacity(.7),
              ],
            ),
            border: Border.all(
              width: 1.5,
              color: Color(0xFF1B2727).withOpacity(.2),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
