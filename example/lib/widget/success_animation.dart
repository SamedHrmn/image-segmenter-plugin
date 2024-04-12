import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SuccessAnimation extends StatefulWidget {
  const SuccessAnimation({super.key, required this.onCompleted});

  @override
  State<SuccessAnimation> createState() => _SuccessAnimationState();

  final void Function() onCompleted;
}

class _SuccessAnimationState extends State<SuccessAnimation> with SingleTickerProviderStateMixin {
  late final AnimationController successController;

  @override
  void initState() {
    super.initState();
    successController = AnimationController(vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.onCompleted();
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/success.json',
      controller: successController,
      height: 120,
      repeat: false,
      animate: false,
      onLoaded: (p0) {
        successController.duration = p0.duration;
        successController.forward();
      },
    );
  }
}
