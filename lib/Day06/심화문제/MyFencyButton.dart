import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'HelloTextField',
      debugShowCheckedModeBanner: false,
      home: MyFencyButton(),
    );
  }
}

class MyFencyButton extends StatefulWidget {
  const MyFencyButton({super.key});

  @override
  State<MyFencyButton> createState() => _MyFencyButtonState();
}

class _MyFencyButtonState extends State<MyFencyButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Alignment> _topAlignmentAnimation;
  late Animation<Alignment> _bottomAlignmentAnimation;
  final List<Color> _buttonColors = [
    Colors.black,
    Colors.red,
    Colors.orangeAccent,
    Colors.green,
    Colors.teal,
    Colors.blue,
    Colors.purple,
    Colors.pink,
  ];
  int _index = 0;

  void changeButtonStyle() {
    setState(() {
      if (_index + 1 == _buttonColors.length) {
        _index = 0;
      } else {
        _index++;
      }
    });
    if (_index == 0) {
      _animationController.stop();
    } else if (_animationController.isAnimating == false) {
      // _animationController.repeat();
    }
  }

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
    _topAlignmentAnimation = TweenSequence([
      TweenSequenceItem(
        tween: Tween(begin: Alignment.topLeft, end: Alignment.topRight),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween(begin: Alignment.topRight, end: Alignment.bottomRight),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween(begin: Alignment.bottomRight, end: Alignment.bottomLeft),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween(begin: Alignment.bottomLeft, end: Alignment.topLeft),
        weight: 1,
      ),
    ]).animate(_animationController);
    _bottomAlignmentAnimation = TweenSequence([
      TweenSequenceItem(
        tween: Tween(begin: Alignment.bottomRight, end: Alignment.bottomLeft),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween(begin: Alignment.bottomLeft, end: Alignment.topLeft),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween(begin: Alignment.topLeft, end: Alignment.topRight),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween(begin: Alignment.topRight, end: Alignment.bottomRight),
        weight: 1,
      ),
    ]).animate(_animationController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, _) => Container(
              width: 210,
              height: 140,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    _buttonColors[_index],
                    _index == 0 ? Colors.black : Colors.white,
                  ],
                  begin: _topAlignmentAnimation.value,
                  end: _bottomAlignmentAnimation.value,
                ),
                borderRadius: BorderRadius.circular(23),
                boxShadow: [
                  BoxShadow(
                    color: _buttonColors[_index],
                    blurRadius: 5.0,
                    spreadRadius: 3.0,
                  ),
                ],
              ),
              child: Expanded(
                child: OutlinedButton(
                  onPressed: changeButtonStyle,
                  style: OutlinedButton.styleFrom(
                    textStyle: GoogleFonts.lobster(fontSize: 30),
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    side: _index == 0
                        ? const BorderSide(color: Colors.white)
                        : BorderSide.none,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Flutter Boot\nClick me 😎',
                    style: TextStyle(
                      shadows: [
                        Shadow(
                          color: _buttonColors[_index],
                          blurRadius: 2,
                        ),
                        Shadow(
                          color: _buttonColors[_index],
                          blurRadius: 4,
                        ),
                        Shadow(
                          color: _buttonColors[_index],
                          blurRadius: 6,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
