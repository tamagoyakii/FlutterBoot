import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FlutterBootPlus(),
    );
  }
}

class FlutterBootPlus extends StatelessWidget {
  const FlutterBootPlus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.fromLTRB(15, 30, 15, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'FlutterBoot Plus',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Flexible(
              child: PlusFeatures(features: features),
            ),
            const Column(
              children: [
                Text(
                  'Restore subscription',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Auto-renews for \$25/month until canceled',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            const FilledButton(
              onPressed: null,
              style: ButtonStyle(
                foregroundColor: MaterialStatePropertyAll(Colors.white),
                backgroundColor: MaterialStatePropertyAll(Colors.black),
              ),
              child: Text('Subscribe'),
            ),
          ],
        ),
      ),
    );
  }
}

class PlusFeatures extends StatelessWidget {
  final List<Feature> features;

  const PlusFeatures({
    Key? key,
    required this.features,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: features.length,
      itemBuilder: (context, index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 15, 0),
              child: features[index].icon,
            ),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    features[index].title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(features[index].description),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class Feature {
  final Icon icon;
  final String title;
  final String description;

  Feature({
    required this.icon,
    required this.title,
    required this.description,
  });
}

List<Feature> features = [
  Feature(
    icon: const Icon(Icons.bolt, size: 30),
    title: 'Premium features',
    description:
        'Plus subscribers have access to FlutterBoot+ and our latest beta features.',
  ),
  Feature(
    icon: const Icon(Icons.whatshot, size: 30),
    title: 'Priority access',
    description:
        'You\'ll be able to use FlutterBoot+ even when demand is high ',
  ),
  Feature(
    icon: const Icon(Icons.speed, size: 30),
    title: 'Ultra-fast',
    description: 'Enjoy even faster response speeds when using FlutterBoot',
  ),
];
