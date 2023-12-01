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
  late final AnimationController _scaleController;
  late final Animation<double> _scaleAnimation;
  final List<Widget> _stars = [];
  int _count = 0;

  @override
  void initState() {
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 60),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _scaleController,
        curve: Curves.easeIn,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  void _shootStar() {
    setState(() {
      _stars.add(
        LayoutBuilder(
          builder: (context, constraints) => AnimatedStar(
            max: constraints.biggest,
            onAnimationComplete: () {
              setState(() {
                _count++;
                _scaleController.forward().then((_) {
                  _scaleController.reverse();
                });
              });
            },
          ),
        ),
      );
    });
  }

  Widget _buildShootingCount() {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.green.shade700,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text('$_count', style: const TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  Widget _buildObstacle() {
    return const Center(
      child: Text(
        'No matter what widgets are in the middle\nanimation whould not be obscured.',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.grey),
      ),
    );
  }

  Widget _buildShootingButton() {
    return ElevatedButton(
      onPressed: _shootStar,
      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
      child: const Text('Shoot Star!', style: TextStyle(color: Colors.white)),
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
            Positioned(top: 20, left: 20, child: _buildShootingCount()),
            Positioned.fill(child: _buildObstacle()),
            Positioned(bottom: 20, right: 20, child: _buildShootingButton()),
            ..._stars,
          ],
        ),
      ),
    );
  }
}

class AnimatedStar extends StatefulWidget {
  final VoidCallback onAnimationComplete;
  final Size max;
  const AnimatedStar({
    super.key,
    required this.max,
    required this.onAnimationComplete,
  });

  @override
  State<AnimatedStar> createState() => _AnimatedStarState();
}

class _AnimatedStarState extends State<AnimatedStar>
    with TickerProviderStateMixin {
  late final AnimationController _slideController;
  late final AnimationController _scaleController;
  late final AnimationController _rotationController;
  late final Animation<Rect?> _slideAnimation;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _slideAnimation = RectTween(
      begin:
          Rect.fromLTWH(widget.max.width - 80, widget.max.height - 50, 50, 50),
      end: const Rect.fromLTWH(50, 50, 50, 50),
    ).animate(
      CurvedAnimation(
        parent: _slideController,
        curve: Curves.linear,
      ),
    );
    _scaleAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _scaleController,
        curve: Curves.easeIn,
      ),
    );
    _rotationAnimation = Tween(begin: 0.0, end: 0.2).animate(
      CurvedAnimation(
        parent: _rotationController,
        curve: Curves.linear,
      ),
    );

    _slideController.forward().whenCompleteOrCancel(() {
      widget.onAnimationComplete();
    });
    _scaleController.forward().then((_) => _scaleController.reverse());
    _rotationController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    _scaleController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RelativePositionedTransition(
          size: widget.max,
          rect: _slideAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: RotationTransition(
              turns: _rotationAnimation,
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
  }
}
