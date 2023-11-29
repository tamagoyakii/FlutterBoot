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
      home: HelloLayout(),
    );
  }
}

class HelloLayout extends StatelessWidget {
  const HelloLayout({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text(
          'I can layout this',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: width,
              color: Colors.black,
              child: GridView.count(
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                crossAxisCount: 2,
                children: [
                  Container(color: Colors.green),
                  Container(
                    color: Colors.red,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(color: Colors.red),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.orange,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(color: Colors.white),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(color: Colors.orange),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Container(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(flex: 2, child: Container(color: Colors.purple)),
                  Expanded(flex: 1, child: Container(color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
