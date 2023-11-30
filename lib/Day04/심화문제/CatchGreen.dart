import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class GreenAlignment {
  static final _random = Random();
  final Alignment position;

  GreenAlignment()
      : position = Alignment(
          _random.nextDouble() * 2 - 1,
          _random.nextDouble() * 2 - 1,
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
  late Timer _timer;
  bool _isPlaying = false;
  bool _showGreen = false;
  GreenAlignment _green = GreenAlignment();
  DateTime _startTime = DateTime.now();
  double _timeElapsed = 0.0;

  void _startTimer() {
    setState(() {
      _timeElapsed = 0.0;
      _isPlaying = true;
      _green = GreenAlignment();
    });

    Future.delayed(const Duration(seconds: 1), () {
      _startTime = DateTime.now();
      setState(() {
        _showGreen = true;
      });
      _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
        setState(() {
          final currentTime = DateTime.now();
          final difference = currentTime.difference(_startTime);
          _timeElapsed = difference.inMilliseconds / 1000.0;
        });
      });
    });
  }

  void _stopTimer() {
    _isPlaying = false;
    _showGreen = false;
    _timer.cancel();
  }

  Widget _buildTimerWidget() {
    int minutes = (_timeElapsed ~/ 60).toInt();
    int seconds = (_timeElapsed.toInt() % 60).toInt();
    int milliseconds = ((_timeElapsed % 1) * 1000).toInt();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('$minutes:'),
        Text('${seconds.toString().padLeft(2, '0')}.'),
        Text(milliseconds.toString().padLeft(3, '0')),
      ],
    );
  }

  Widget _buildGreenWidget() {
    return GestureDetector(
      onTap: () => setState(() {
        _stopTimer();
      }),
      child: _showGreen
          ? Stack(
              children: [
                Align(
                  alignment: _green.position,
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
              onPressed: _isPlaying ? null : _startTimer,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isPlaying ? Colors.grey : null,
              ),
              child: const Text(
                'Start!',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 10),
          _buildTimerWidget(),
          const SizedBox(height: 10),
          Expanded(
            child: Stack(
              children: [
                Expanded(child: Container(color: Colors.black)),
                _buildGreenWidget(),
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
