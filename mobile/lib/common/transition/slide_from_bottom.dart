import 'package:flutter/material.dart';

class SlideFromBottomTransition extends StatefulWidget {
  SlideFromBottomTransition({required this.child});

  final Widget child;

  @override
  _SlideFromBottomTransitionState createState() =>
      _SlideFromBottomTransitionState();
}

class _SlideFromBottomTransitionState extends State<SlideFromBottomTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // Create an AnimationController
    _controller = AnimationController(
      duration:
          const Duration(milliseconds: 500), // Adjust the duration as needed
      vsync: this,
    );

    // Create an animation with a Tween
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Start from the bottom
      end: Offset.zero, // Slide to the top
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    // Start the animation
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: widget.child,
    );
  }
}
