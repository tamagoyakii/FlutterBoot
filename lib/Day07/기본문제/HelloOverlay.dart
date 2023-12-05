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
  final List<String> _buttonTexts = ['Hello!', 'Press', 'any', 'button!'];
  OverlayEntry? _overlayEntry;

  void createOverlay({required LayerLink targetLink}) {
    removeOverlay();
    assert(_overlayEntry == null);
    _overlayEntry = OverlayEntry(
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
    Overlay.of(context, debugRequiredFor: widget).insert(_overlayEntry!);
  }

  void removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry?.dispose();
    _overlayEntry = null;
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
    return GestureDetector(
      onTap: removeOverlay,
      child: Scaffold(
        appBar: AppBar(title: const Text('Hello Overlay')),
        body: SafeArea(
          child: ListView.separated(
            padding: const EdgeInsets.all(30),
            itemCount: _buttonTexts.length,
            itemBuilder: (context, index) =>
                _buildOverlayButton(text: _buttonTexts[index]),
            separatorBuilder: (context, index) => const SizedBox(height: 15),
          ),
        ),
      ),
    );
  }
}
