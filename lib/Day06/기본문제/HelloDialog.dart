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

  List<int> generateRandomIntegers() {
    final random = Random();
    return List.generate(3, (index) => random.nextInt(100));
  }

  Widget buildNumbers() {
    final numbers = generateRandomIntegers();

    return SizedBox(
      height: 35,
      width: 190,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, i) => TextButton(
          onPressed: () {
            _point.value = numbers[i];
            Navigator.pop(context);
          },
          child: Text(
            '${numbers[i]}',
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
        separatorBuilder: (context, i) => const SizedBox(width: 10),
        itemCount: numbers.length,
      ),
    );
  }

  Widget buildDialog() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
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
          const SizedBox(height: 20),
          const Text('Choose one of the points below!'),
          const Text(
            'If you don\'t make a selection, your current score will be retained.',
          ),
          const SizedBox(height: 30),
          Align(
            alignment: Alignment.bottomRight,
            child: buildNumbers(),
          ),
        ],
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
                valueListenable: _point,
                builder: (context, value, _) => Text(
                  'Your point: ${_point.value}',
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      content: buildDialog(),
                    ),
                  );
                },
                child: const Text('I want more points!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
