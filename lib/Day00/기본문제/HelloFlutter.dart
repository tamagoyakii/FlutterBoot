import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HelloFlutter(),
    );
  }
}

class HelloFlutter extends StatefulWidget {
  const HelloFlutter({super.key});

  @override
  State<HelloFlutter> createState() => _HelloFlutterState();
}

class _HelloFlutterState extends State<HelloFlutter> {
  int score = 0;

  void increaseScore() {
    setState(() {
      score++;
    });
  }

  void decreaseScore() {
    setState(() {
      score--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.home),
        title: const Text('Hello Flutter'),
        actions: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 15, 0),
            child: const Icon(Icons.help),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Your score',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 25,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '$score',
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                FilledButton(
                  onPressed: increaseScore,
                  child: const Icon(
                    Icons.add,
                    size: 15,
                  ),
                ),
                const SizedBox(width: 15),
                FilledButton(
                  onPressed: decreaseScore,
                  child: const Icon(
                    Icons.remove,
                    size: 15,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
