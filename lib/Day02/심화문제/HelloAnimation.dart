import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'ShootingStar',
      debugShowCheckedModeBanner: false,
      home: HelloAnimation(),
    );
  }
}

class HelloAnimation extends StatefulWidget {
  const HelloAnimation({super.key});

  @override
  State<HelloAnimation> createState() => _HelloAnimationState();
}

class _HelloAnimationState extends State<HelloAnimation>
    with TickerProviderStateMixin {
  late final AnimationController _slideController;
  late final AnimationController _rotationController;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _rotationAnimation;

  @override
  void initState() {
    _slideController = AnimationController(
      vsync: this,
    );
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _slideAnimation = Tween(
      begin: const Offset(0.0, 0.0),
      end: const Offset(10.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _slideController,
        curve: Curves.linear,
      ),
    );
    _rotationAnimation = Tween(begin: 0.0, end: 0.2).animate(
      CurvedAnimation(
        parent: _rotationController,
        curve: Curves.linear,
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    _slideController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              child: SlideTransition(
                position: _slideAnimation,
                child: RotationTransition(
                  turns: _rotationAnimation,
                  child: Container(
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    height: 60,
                    width: 60,
                    child: const Center(
                      child: Icon(Icons.star, color: Colors.yellow, size: 50),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
