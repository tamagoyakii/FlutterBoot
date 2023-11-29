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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: width,
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              child: GridView(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  crossAxisCount: 2,
                ),
                children: [
                  Container(color: Colors.green),
                  Container(
                    color: Colors.red,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: width * 0.25,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.orange,
                    child: Column(
                      children: [
                        Container(
                          height: width * 0.325,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Container(
                            height: width * 0.25,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double height = constraints.maxHeight;

                  return Column(
                    children: [
                      Container(
                        height: height * 0.7,
                        decoration: const BoxDecoration(
                          color: Colors.purple,
                        ),
                      ),
                      Container(
                        height: height * 0.3,
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
