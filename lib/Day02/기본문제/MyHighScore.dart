import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'MyHighScore',
      debugShowCheckedModeBanner: false,
      home: MyHighScore(),
    );
  }
}

class MyHighScore extends StatefulWidget {
  const MyHighScore({super.key});

  @override
  State<MyHighScore> createState() => _MyHighScoreState();
}

class _MyHighScoreState extends State<MyHighScore> {
  final ValueNotifier<double> _progress = ValueNotifier(0.0);
  Timer? _timer;
  int _score = 0;

  void onButtonPress() {
    setTimer();
    setState(() {
      if (_progress.value < 1) {
        _progress.value += 0.4;
      }
      if (_progress.value >= 1) {
        _score++;
      }
    });
  }

  void setTimer() {
    if (_timer?.isActive != true) {
      _timer = Timer.periodic(const Duration(milliseconds: 15), (timer) {
        if (_progress.value > 0) {
          _progress.value -= 0.03;
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _progress.addListener(() {
      if (_progress.value <= 0) {
        setState(() {
          _score = 0;
          _progress.value = 0;
          _timer?.cancel();
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _progress.dispose();
    _timer?.cancel();
  }

  Widget _buildProgressBar() {
    double barHeight = 600;

    return ValueListenableBuilder(
      valueListenable: _progress,
      builder: (context, value, _) => Container(
        height: barHeight,
        width: 40,
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(15),
            topLeft: Radius.circular(15),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: value * barHeight,
              constraints: BoxConstraints(maxHeight: barHeight, minHeight: 0),
              decoration: BoxDecoration(
                color: Colors.purpleAccent.shade400,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(12),
                  topLeft: Radius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScore() {
    return Center(
      child: Column(
        children: [
          const Text('Your score', style: TextStyle(fontSize: 30)),
          const SizedBox(height: 10),
          Text(
            '$_score',
            style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: SafeArea(
        child: Stack(
          children: [
            _buildScore(),
            Positioned(
              bottom: 20,
              right: 20,
              child: Column(
                children: [
                  _buildProgressBar(),
                  const SizedBox(height: 8),
                  FloatingActionButton(
                    onPressed: onButtonPress,
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
