import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'HelloLayout',
      debugShowCheckedModeBanner: false,
      home: MySlackAvatar(),
    );
  }
}

class MySlackAvatar extends StatefulWidget {
  const MySlackAvatar({super.key});

  @override
  State<MySlackAvatar> createState() => _MySlackAvatarState();
}

class _MySlackAvatarState extends State<MySlackAvatar> {
  double bighead = 50;
  double roundedShoulder = 100;

  void changeHeadSize(double value) {
    setState(() {
      bighead = value;
    });
  }

  void changeBodySize(double value) {
    setState(() {
      roundedShoulder = value;
    });
  }

  Widget avatar() {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.blue.shade700,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(height: 15),
          Flexible(
            child: Center(
              child: Container(
                width: 70 + bighead * 0.4,
                height: 70 + bighead * 0.4,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(100),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 65,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 170 + roundedShoulder * 0.15,
                  height: 55 + roundedShoulder * 0.08,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(60),
                      topLeft: Radius.circular(60),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              avatar(),
              const SizedBox(height: 50),
              Slider(
                value: bighead,
                max: 100,
                onChanged: changeHeadSize,
              ),
              const SizedBox(height: 20),
              Slider(
                value: roundedShoulder,
                max: 100,
                onChanged: changeBodySize,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
