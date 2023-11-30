import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class GreenAlignment {
  static final _rng = Random();
  final Alignment alignment;

  GreenAlignment()
      : alignment = Alignment(
          _rng.nextDouble() * 2 - 1,
          _rng.nextDouble() * 2 - 1,
        );
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'CatchGreen',
      debugShowCheckedModeBanner: false,
      home: CatchGreen(),
    );
  }
}

class CatchGreen extends StatefulWidget {
  const CatchGreen({super.key});

  @override
  State<CatchGreen> createState() => _CatchGreenState();
}

class _CatchGreenState extends State<CatchGreen> {
  late Timer timer;
  bool isPlaying = false;
  GreenAlignment green = GreenAlignment();
  DateTime startTime = DateTime.now();
  double timeElapsed = 0.0;

  void startTimer() {
    setState(() {
      timeElapsed = 0.0;
      green = GreenAlignment();
    });

    Future.delayed(const Duration(seconds: 1), () {
      startTime = DateTime.now();
      setState(() {
        isPlaying = true;
      });
      timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
        setState(() {
          final currentTime = DateTime.now();
          final diffrence = currentTime.difference(startTime);
          timeElapsed = diffrence.inMilliseconds / 1000.0;
        });
      });
    });
  }

  void stopTimer() {
    isPlaying = false;
    timer.cancel();
  }

  Widget _buildTimer() {
    int minutes = timeElapsed ~/ 60;
    int seconds = timeElapsed.toInt() % 60;
    int milliseconds = (timeElapsed % 1 * 1000).toInt();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('$minutes:'),
        Text('${seconds.toString().padLeft(2, '0')}.'),
        Text(milliseconds.toString().padLeft(3, '0')),
      ],
    );
  }

  Widget _buildGreen() {
    return Align(
      alignment: green.alignment,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.lightGreenAccent.shade400,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catch green game'),
        backgroundColor: Colors.lightBlue.shade100,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: isPlaying ? null : startTimer,
              style: ElevatedButton.styleFrom(
                backgroundColor: isPlaying ? Colors.grey : null,
              ),
              child: const Text(
                'Start!',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 10),
          _buildTimer(),
          const SizedBox(height: 10),
          Expanded(
            child: Stack(
              children: [
                Expanded(child: Container(color: Colors.black)),
                GestureDetector(
                  onTap: () => setState(() {
                    stopTimer();
                  }),
                  child: isPlaying ? Stack(children: [_buildGreen()]) : null,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.lightBlue.shade100,
      ),
    );
  }
}
