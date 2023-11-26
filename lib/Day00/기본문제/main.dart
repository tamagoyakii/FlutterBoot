import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HelloFlutter(),
    );
  }
}

class HelloFlutter extends StatefulWidget {
  @override
  State<HelloFlutter> createState() => HelloFlutterState();
}

class HelloFlutterState extends State<HelloFlutter> {
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
          leading: Icon(Icons.home),
          title: Text('Hello Flutter'),
          actions: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
              child: Icon(Icons.help),
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
                style: TextStyle(
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
        ));
  }
}
