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
  ValueNotifier<double> gauge = ValueNotifier(0.0);
  Timer? timer;
  int score = 0;

  void addScore() {
    setState(() {
      score++;
    });
  }

  void resetScore() {
    setState(() {
      score = 0;
      gauge.value = 0;
    });
  }

  void onButtonPress() {
    setTimer();
    setState(() {
      if (gauge.value < 1) {
        gauge.value += 0.4;
      }
      if (gauge.value >= 1) {
        addScore();
      }
    });
  }

  void setTimer() {
    if (timer?.isActive != true) {
      timer = Timer.periodic(const Duration(milliseconds: 15), (timer) {
        if (gauge.value > 0) {
          gauge.value -= 0.03;
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    gauge.addListener(() {
      if (gauge.value <= 0) {
        resetScore();
        timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    gauge.dispose();
    timer?.cancel();
  }

  Widget _score() {
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

  Widget _gaugeBar() {
    return Align(
      alignment: Alignment.bottomRight,
      child: ValueListenableBuilder(
        valueListenable: gauge,
        builder: (context, value, _) => LayoutBuilder(
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
                    height: value * barHeight,
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
            _score(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 24, 80),
                child: _gaugeBar(),
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
