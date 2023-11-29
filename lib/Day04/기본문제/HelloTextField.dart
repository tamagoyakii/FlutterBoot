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
  List<TextEditingController> inputControllers = [
    TextEditingController(),
    TextEditingController(),
  ];
  List<FocusNode> inputFocusNodes = [
    FocusNode(),
    FocusNode(),
  ];

  Widget _textField({
    required int preIndex,
    required int fieldIndex,
    required int postIndex,
  }) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: (RawKeyEvent event) {
        if (event.runtimeType == RawKeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.backspace &&
            inputControllers[fieldIndex].text.isEmpty) {
          FocusScope.of(context).requestFocus(inputFocusNodes[preIndex]);
        }
      },
      child: TextField(
        controller: inputControllers[fieldIndex],
        focusNode: inputFocusNodes[fieldIndex],
        onEditingComplete: () {
          FocusScope.of(context).requestFocus(inputFocusNodes[postIndex]);
        },
      ),
    );
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
                child: _textField(preIndex: 1, fieldIndex: 0, postIndex: 1),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: _textField(preIndex: 0, fieldIndex: 1, postIndex: 0),
              ),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ),
    );
  }
}
