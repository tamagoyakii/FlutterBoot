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
  double gaugeValue = 0.0;
  int score = 0;
  late Timer timer;

  void addScore() {
    setState(() {
      score++;
    });
  }

  void resetScore() {
    setState(() {
      score = 0;
      gaugeValue = 0.0;
    });
  }

  void onButtonPress() {
    setState(() {
      if (gaugeValue < 1) {
        gaugeValue += 0.4;
      }
      if (gaugeValue >= 1) {
        addScore();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 15), (timer) {
      if (gaugeValue > 0) {
        setState(() {
          gaugeValue -= 0.03;
        });
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Widget _buildGaugeBar() {
    return Align(
      alignment: Alignment.bottomRight,
      child: LayoutBuilder(
        builder: (context, constraints) {
          double barHeight = constraints.maxHeight * 0.8;
          return Container(
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
                  height: gaugeValue * barHeight,
                  constraints:
                      BoxConstraints(maxHeight: barHeight, minHeight: 0),
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
          );
        },
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
            '$score',
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
        child: Column(
          children: [
            _buildScore(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 24, bottom: 80),
                child: _buildGaugeBar(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onButtonPress,
        child: const Icon(Icons.add),
      ),
    );
  }
}
