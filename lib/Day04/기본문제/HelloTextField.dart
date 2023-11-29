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
  TextEditingController leftInputController = TextEditingController();
  TextEditingController rightInputController = TextEditingController();
  FocusNode leftInputFocusNode = FocusNode();
  FocusNode rightInputFocusNode = FocusNode();

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
                child: RawKeyboardListener(
                  focusNode: FocusNode(),
                  onKey: (RawKeyEvent event) {
                    if (event.runtimeType == RawKeyDownEvent &&
                        event.logicalKey == LogicalKeyboardKey.backspace &&
                        leftInputController.text.isEmpty) {
                      FocusScope.of(context).requestFocus(rightInputFocusNode);
                    }
                  },
                  child: TextField(
                    controller: leftInputController,
                    focusNode: leftInputFocusNode,
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(rightInputFocusNode);
                    },
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: RawKeyboardListener(
                  focusNode: FocusNode(),
                  onKey: (RawKeyEvent event) {
                    if (event.runtimeType == RawKeyDownEvent &&
                        event.logicalKey == LogicalKeyboardKey.backspace &&
                        rightInputController.text.isEmpty) {
                      FocusScope.of(context).requestFocus(leftInputFocusNode);
                    }
                  },
                  child: TextField(
                    controller: rightInputController,
                    focusNode: rightInputFocusNode,
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(leftInputFocusNode);
                    },
                  ),
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
