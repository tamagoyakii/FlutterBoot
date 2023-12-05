import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'HelloOverlay',
      debugShowCheckedModeBanner: false,
      home: HelloOverlay(),
    );
  }
}

class HelloOverlay extends StatefulWidget {
  const HelloOverlay({super.key});

  @override
  State<HelloOverlay> createState() => _HelloOverlayState();
}

class _HelloOverlayState extends State<HelloOverlay> {
  OverlayEntry? overlayEntry;

  void createOverlay({required LayerLink targetLink}) {
    removeOverlay();

    assert(overlayEntry == null);

    overlayEntry = OverlayEntry(
      builder: (BuildContext context) => Stack(
        children: [
          CompositedTransformFollower(
            offset: const Offset(200, -30),
            link: targetLink,
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(3),
                ),
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: const Text(
                  '↓ You clicked this 😎',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    Overlay.of(context, debugRequiredFor: widget).insert(overlayEntry!);
  }

  void removeOverlay() {
    overlayEntry?.remove();
    overlayEntry?.dispose();
    overlayEntry = null;
  }

  @override
  void dispose() {
    removeOverlay();
    super.dispose();
  }

  Widget _buildOverlayButton({required String text}) {
    final LayerLink buttonLayerLink = LayerLink();

    return CompositedTransformTarget(
      link: buttonLayerLink,
      child: ElevatedButton(
        onPressed: () => createOverlay(targetLink: buttonLayerLink),
        child: Text(text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hello Overlay')),
      body: SafeArea(
        child: Stack(
          children: [
            GestureDetector(onTap: removeOverlay),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildOverlayButton(text: 'Hello!'),
                  const SizedBox(height: 15),
                  _buildOverlayButton(text: 'Press'),
                  const SizedBox(height: 15),
                  _buildOverlayButton(text: 'any'),
                  const SizedBox(height: 15),
                  _buildOverlayButton(text: 'button!'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
