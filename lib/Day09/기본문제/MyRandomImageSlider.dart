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
      title: 'MyRandomImageSlider',
      debugShowCheckedModeBanner: false,
      home: MyRandomImageSlider(),
    );
  }
}

class MyRandomImageSlider extends StatefulWidget {
  const MyRandomImageSlider({super.key});

  @override
  State<MyRandomImageSlider> createState() => _MyRandomImageSliderState();
}

class _MyRandomImageSliderState extends State<MyRandomImageSlider> {
  final List<String> _images = [];
  int _index = 0;
  int _max = 0;

  String getRandomImageSrc() {
    return 'https://picsum.photos/id/${Random().nextInt(1000) + 1}/200/200';
  }

  @override
  void initState() {
    _images.add(getRandomImageSrc());
    super.initState();
  }

  void showNextImage() {
    if (_index == _max) _images.add(getRandomImageSrc());
    setState(() {
      _index++;
      _max = max(_index, _max);
    });
    debugPrint('${_images.length} $_index $_max');
  }

  void showPreviousImage() {
    if (_index <= 0) return;
    setState(() {
      _index--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Click left and right')),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: showPreviousImage,
                child: const Icon(Icons.arrow_back),
              ),
              ElevatedButton(
                onPressed: showNextImage,
                child: const Icon(Icons.arrow_forward),
              ),
            ],
          ),
          Expanded(
            child: Image.network(
              _images[_index],
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                if (frame == null) {
                  return const Center(child: Text('Loading...'));
                }
                return child;
              },
              errorBuilder: (context, error, stackTrace) {
                return const Center(child: Text('Oops! Something went wrong'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
