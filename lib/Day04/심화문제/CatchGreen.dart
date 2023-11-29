import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catch green game'),
        backgroundColor: Colors.lightBlue.shade100,
      ),
      body: const Column(
        children: [
          Center(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.lightBlue.shade100,
      ),
    );
  }
}
