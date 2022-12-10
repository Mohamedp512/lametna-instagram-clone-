import 'package:flutter/material.dart';
import 'package:instantgram/presentations/components/animations/models/lottie_animation.dart';
import 'package:lottie/lottie.dart';

class LottieAnimationView extends StatelessWidget {
  final LottieAnimation animation;
  final bool repreat;
  final bool reverse;
  const LottieAnimationView({
    Key? key,
    required this.animation,
    this.repreat = true,
    this.reverse = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      animation.fullPath,
      repeat: repreat,
      reverse: reverse,
    );
  }
}
