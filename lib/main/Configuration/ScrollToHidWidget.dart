import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScrollToHidWidget extends StatefulWidget {
  final Widget child;
  final ScrollController controller;
  final Duration duration;
  final double height;
  const ScrollToHidWidget({
    Key? key,
    required this.child,
    required this.controller,
    this.duration = const Duration(milliseconds: 200),
    this.height = kBottomNavigationBarHeight,
  }) : super(key: key);

  @override
  State<ScrollToHidWidget> createState() => _ScrollToHidWidgetState();
}

class _ScrollToHidWidgetState extends State<ScrollToHidWidget> {
  bool isVisible = true;
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(listen);
  }

  @override
  void dispose() {
    widget.controller.removeListener(listen);
    super.dispose();
  }

  void listen() {
    final direction = widget.controller.position.userScrollDirection;
    if (direction == ScrollDirection.forward) {
      show();
    } else if (direction == ScrollDirection.reverse) {
      hide();
    }
  }

  void show() {
    if (!isVisible) setState(() => isVisible = true);
  }

  void hide() {
    if (isVisible) setState(() => isVisible = false);
  }

  @override
  Widget build(BuildContext context) => AnimatedContainer(
        duration: widget.duration,
        height: isVisible ? widget.height : 0,
        child: Wrap(children: [widget.child]),
      );
}
