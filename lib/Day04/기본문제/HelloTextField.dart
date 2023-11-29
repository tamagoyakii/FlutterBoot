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

  @override
  void dispose() {
    super.dispose();
    for (var el in inputFocusNodes) {
      el.dispose();
    }
  }

  Widget _buildTextField({
    required int prevInded,
    required int curIndex,
    required int nextIndex,
  }) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: (RawKeyEvent event) {
        if (event is RawKeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.backspace &&
            inputControllers[curIndex].text.isEmpty) {
          FocusScope.of(context).requestFocus(inputFocusNodes[prevInded]);
        }
      },
      child: TextField(
        controller: inputControllers[curIndex],
        focusNode: inputFocusNodes[curIndex],
        onEditingComplete: () {
          FocusScope.of(context).requestFocus(inputFocusNodes[nextIndex]);
        },
        textInputAction: TextInputAction.next,
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
          child: Form(
            // key: this.formKey,
            child: Row(
              children: [
                const SizedBox(width: 20),
                Expanded(
                  child: _buildTextField(
                    prevInded: 1,
                    curIndex: 0,
                    nextIndex: 1,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _buildTextField(
                    prevInded: 0,
                    curIndex: 1,
                    nextIndex: 0,
                  ),
                ),
                const SizedBox(width: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
