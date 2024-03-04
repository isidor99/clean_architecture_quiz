import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quiz_app/features/home/presentation/pages/home_page.dart';

// TODO: this widget should contain menu
class PageContainer extends StatelessWidget {
  final Animation zeroToOneTransitionAnimation;
  final Animation scaleAnimation;

  const PageContainer({
    Key? key,
    required this.zeroToOneTransitionAnimation,
    required this.scaleAnimation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // get size
    Size size = MediaQuery.of(context).size;

    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateY(1 * zeroToOneTransitionAnimation.value -
            30 * (zeroToOneTransitionAnimation.value) * pi / 180),
      child: Transform.translate(
        offset: Offset(
          zeroToOneTransitionAnimation.value * size.width * 3 / 5,
          0,
        ),
        child: Transform.scale(
          scale: scaleAnimation.value,
          child: const ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(24)),
            child: HomePage(),
          ),
        ),
      ),
    );
  }
}
