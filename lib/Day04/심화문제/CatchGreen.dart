import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

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
  final Stopwatch _stopwatch = Stopwatch();
  late Timer _timer;
  late Alignment _green;
  bool _isPlaying = false;
  bool _showGreen = false;
  String _elapsedTime = '0:00.000';

  @override
  void dispose() {
    _stopwatch.stop();
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    resetTimer();
    _isPlaying = true;
    _green =
        Alignment(Random().nextDouble() * 2 - 1, Random().nextDouble() * 2 - 1);

    Future.delayed(const Duration(seconds: 1), () {
      _showGreen = true;
      _stopwatch.start();
      _timer = Timer.periodic(const Duration(milliseconds: 4), (Timer timer) {
        setState(() {
          _elapsedTime =
              getFormattedTime(milliseconds: _stopwatch.elapsedMilliseconds);
        });
      });
    });
  }

  void stopTimer() {
    _stopwatch.stop();
    _timer.cancel();
    setState(() {
      _elapsedTime =
          getFormattedTime(milliseconds: _stopwatch.elapsedMilliseconds);
    });
  }

  void resetTimer() {
    _stopwatch.reset();
    setState(() {
      _elapsedTime = '0:00.000';
    });
  }

  String getFormattedTime({required int milliseconds}) {
    int seconds = (milliseconds / 1000).truncate();
    int minutes = (seconds / 60).truncate();

    String milliSecondsStr = (milliseconds % 1000).toString().padLeft(3, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return '$minutesStr:$secondsStr.$milliSecondsStr';
  }

  Widget _buildGreenDot() {
    return GestureDetector(
      onTap: () {
        stopTimer();
        setState(() {
          _isPlaying = false;
          _showGreen = false;
        });
      },
      child: _showGreen
          ? Stack(
              children: [
                Align(
                  alignment: _green,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.lightGreenAccent.shade400,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            )
          : const SizedBox.shrink(),
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
              onPressed: _isPlaying ? null : startTimer,
              child: const Text(
                'Start!',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(_elapsedTime),
          const SizedBox(height: 10),
          Expanded(
            child: Stack(
              children: [
                Expanded(child: Container(color: Colors.black)),
                _buildGreenDot(),
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
