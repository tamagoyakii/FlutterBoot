import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'HelloDialog',
      debugShowCheckedModeBanner: false,
      home: HelloDialog(),
    );
  }
}

class HelloDialog extends StatefulWidget {
  const HelloDialog({super.key});

  @override
  State<HelloDialog> createState() => _HelloDialogState();
}

class _HelloDialogState extends State<HelloDialog> {
  final ValueNotifier<int> _point = ValueNotifier(0);

  List<int> generateRandomIntegers({required int count}) {
    final random = Random();
    return List.generate(count, (index) => random.nextInt(100));
  }

  Widget _buildButton() {
    return ElevatedButton(
      onPressed: () {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Choose one of the points below!'),
            content: const Text(
              'If you don\'t make a selection, your current score will be retained.',
            ),
            actions: generateRandomIntegers(count: 3)
                .map(
                  (point) => TextButton(
                    onPressed: () {
                      _point.value = point;
                      Navigator.pop(context);
                    },
                    child: Text('$point'),
                  ),
                )
                .toList(),
          ),
        );
      },
      child: const Text('I want more points!'),
    );
  }

  Widget _buildPoint() {
    return ValueListenableBuilder(
      valueListenable: _point,
      builder: (context, value, _) => Text(
        'Your point: ${_point.value}',
        style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildPoint(),
              const SizedBox(height: 20),
              _buildButton(),
            ],
          ),
        ),
      ),
    );
  }
}
