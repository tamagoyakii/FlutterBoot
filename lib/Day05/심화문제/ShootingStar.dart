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
      home: ShootingStar(),
    );
  }
}

class ShootingStar extends StatefulWidget {
  const ShootingStar({super.key});

  @override
  State<ShootingStar> createState() => _ShootingStarState();
}

class _ShootingStarState extends State<ShootingStar>
    with TickerProviderStateMixin {
  late final AnimationController _scaleController = AnimationController(
    duration: const Duration(milliseconds: 60),
    reverseDuration: const Duration(milliseconds: 60),
    vsync: this,
  );

  int _count = 0;
  List<Widget> stars = [];

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  void _shootStar() {
    setState(() {
      stars.add(
        AnimatedStar(
          onAnimationComplete: () {
            setState(() {
              // stars.removeAt(0);
              _count++;
              _scaleController.forward().then((_) {
                _scaleController.reverse();
              });
            });
          },
        ),
      );
    });
  }

  Widget _buildShootingCount() {
    return ScaleTransition(
      scale: Tween<double>(
        begin: 1.0,
        end: 1.2,
      ).animate(
        CurvedAnimation(
          parent: _scaleController,
          curve: Curves.easeIn,
          reverseCurve: Curves.easeOut,
        ),
      ),
      child: Container(
        width: 50,
        height: 50,
        decoration: const BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            '$_count',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              top: 20,
              left: 20,
              child: _buildShootingCount(),
            ),
            const Positioned.fill(
              child: Center(
                child: Text(
                  'No matter what widgets are in the middle\nanimation whould not be obscured.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: ElevatedButton(
                onPressed: _shootStar,
                child: const Text('Shoot Star!'),
              ),
            ),
            ...stars,
          ],
        ),
      ),
    );
  }
}

class AnimatedStar extends StatefulWidget {
  final VoidCallback onAnimationComplete;
  const AnimatedStar({super.key, required this.onAnimationComplete});

  @override
  State<AnimatedStar> createState() => _AnimatedStarState();
}

class _AnimatedStarState extends State<AnimatedStar>
    with TickerProviderStateMixin {
  late final AnimationController _slideController;
  late final AnimationController _scaleController;
  late final AnimationController _rotationController;

  @override
  void initState() {
    super.initState();

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      reverseDuration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      reverseDuration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _slideController.forward().whenCompleteOrCancel(() {
      widget.onAnimationComplete();
    });
    _scaleController.forward().then((_) {
      _scaleController.reverse();
    });
    _rotationController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final Size max = constraints.biggest;
        return Stack(
          children: [
            RelativePositionedTransition(
              size: max,
              rect: RectTween(
                begin: Rect.fromLTWH(max.width - 80, max.height - 50, 50, 50),
                end: const Rect.fromLTWH(60, 75, 50, 50),
              ).animate(
                CurvedAnimation(
                  parent: _slideController,
                  curve: Curves.linear,
                ),
              ),
              child: ScaleTransition(
                scale: Tween(
                  begin: 0.0,
                  end: 1.0,
                ).animate(
                  CurvedAnimation(
                    parent: _scaleController,
                    curve: Curves.easeIn,
                    reverseCurve: Curves.easeOut,
                  ),
                ),
                child: RotationTransition(
                  turns: Tween<double>(begin: 0.0, end: 0.5).animate(
                    CurvedAnimation(
                      parent: _rotationController,
                      curve: Curves.linear,
                    ),
                  ),
                  child: const Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 100,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
