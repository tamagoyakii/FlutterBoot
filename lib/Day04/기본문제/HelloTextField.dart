import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'HelloTextField',
      debugShowCheckedModeBanner: false,
      home: HelloTextField(),
    );
  }
}

class HelloTextField extends StatefulWidget {
  const HelloTextField({super.key});

  @override
  State<HelloTextField> createState() => _HelloTextFieldState();
}

class _HelloTextFieldState extends State<HelloTextField> {
  final TextEditingController _leftInputController =
      TextEditingController(text: 'Hello');
  final TextEditingController _rightInputController =
      TextEditingController(text: 'FlutterBoot!');
  final FocusNode _leftInputFocusNode = FocusNode();
  final FocusNode _rightInputFocusNode = FocusNode();

  KeyEventResult _handleBackspaceKeyEvent({
    required FocusNode node,
    required RawKeyEvent event,
    required TextEditingController controller,
    required FocusNode prevNode,
  }) {
    if (event is RawKeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace &&
        controller.text.isEmpty) {
      prevNode.requestFocus();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  void initState() {
    super.initState();
    _leftInputFocusNode.onKey = (node, event) => _handleBackspaceKeyEvent(
          node: node,
          event: event,
          controller: _leftInputController,
          prevNode: _rightInputFocusNode,
        );
    _rightInputFocusNode.onKey = (node, event) => _handleBackspaceKeyEvent(
          node: node,
          event: event,
          controller: _rightInputController,
          prevNode: _leftInputFocusNode,
        );
  }

  @override
  void dispose() {
    _leftInputController.dispose();
    _rightInputController.dispose();
    _leftInputFocusNode.dispose();
    _rightInputFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello TextField!'),
      ),
      body: SafeArea(
        child: Center(
          child: Row(
            children: [
              const SizedBox(width: 20),
              Expanded(
                child: TextField(
                  controller: _leftInputController,
                  focusNode: _leftInputFocusNode,
                  onEditingComplete: () {
                    _rightInputFocusNode.requestFocus();
                  },
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: TextField(
                  controller: _rightInputController,
                  focusNode: _rightInputFocusNode,
                  onEditingComplete: () {
                    _leftInputFocusNode.requestFocus();
                  },
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ),
    );
  }
}
