import 'package:flutter/material.dart';

class LoopedArrowAnimation extends StatefulWidget {
  const LoopedArrowAnimation({super.key, required this.height});

  final double height;

  @override
  State<LoopedArrowAnimation> createState() => _LoopedArrowAnimationState();
}

class _LoopedArrowAnimationState extends State<LoopedArrowAnimation> with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000))..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        return Transform.translate(
          offset: Tween(begin: const Offset(0, 0), end: Offset(0, -widget.height)).animate(controller).value,
          child: const RotatedBox(
            quarterTurns: 1,
            child: Icon(
              Icons.arrow_back_ios,
            ),
          ),
        );
      },
    );
  }
}
