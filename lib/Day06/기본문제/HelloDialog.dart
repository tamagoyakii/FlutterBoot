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
      title: 'HelloTextField',
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
  final ValueNotifier<int> point = ValueNotifier(0);
  List<int> numbers = [];

  List<int> generateRandomIntegers() {
    final random = Random();
    return List.generate(3, (index) => random.nextInt(100));
  }

  void openDialog() {
    numbers = generateRandomIntegers();
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => buildDialog(),
    );
  }

  Widget buildOption({required int index}) {
    return TextButton(
      onPressed: () {
        point.value = numbers[index];
        Navigator.pop(context);
      },
      child: Text('${numbers[index]}'),
    );
  }

  Widget buildDialog() {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose your next point!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 15),
            const Text('Choose one of the points below!'),
            const Text(
              'If you don\'t make a selection, your current score will be retained.',
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                buildOption(index: 0),
                buildOption(index: 1),
                buildOption(index: 2),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCurrentPoint() {
    return Text(
      'Your point: ${point.value}',
      style: const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
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
              ValueListenableBuilder(
                valueListenable: point,
                builder: (context, value, _) => buildCurrentPoint(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: openDialog,
                child: const Text('I want more points!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
