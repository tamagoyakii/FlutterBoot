import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyCuteGPT(),
    );
  }
}

class MyCuteGPT extends StatefulWidget {
  const MyCuteGPT({super.key});

  @override
  State<MyCuteGPT> createState() => _MyCuteGPTState();
}

class _MyCuteGPTState extends State<MyCuteGPT> {
  final List<String> messages = ['Hello, how can I help you?'];
  TextEditingController inputController = TextEditingController();
  final userName = ['GPT', 'me'];
  final logo = ['G', 'U'];
  final color = [Colors.pink, Colors.purple];
  bool isTextEmpty = true;

  @override
  void initState() {
    super.initState();
    inputController.addListener(() {
      setState(() {
        isTextEmpty = inputController.text.isEmpty;
      });
    });
  }

  void addMessage() {
    setState(() {
      messages.add(inputController.text);
      messages.add(
          'Actually, I don\'t have any features. Go and find the REAL GPT!');
      inputController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: const Text(
          'MyCuteGPT',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        actions: const [
          Icon(Icons.mode),
          SizedBox(width: 10),
          Icon(Icons.more_vert),
          SizedBox(width: 10),
        ],
      ),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) => ChatBox(
          logo: logo[index % 2],
          color: color[index % 2],
          userName: userName[index % 2],
          message: messages[index],
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(15),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: inputController,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Message',
                  suffixIcon: isTextEmpty ? const Icon(Icons.graphic_eq) : null,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15),
            IconButton(
              onPressed: isTextEmpty ? null : addMessage,
              icon: const Icon(Icons.arrow_upward),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    isTextEmpty ? Colors.grey : Colors.green),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ChatBox extends StatelessWidget {
  final String logo;
  final Color color;
  final String userName;
  final String message;

  const ChatBox({
    super.key,
    required this.logo,
    required this.color,
    required this.userName,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        width: 25,
        height: 25,
        child: Center(
          child: Text(
            logo,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ),
      ),
      title: Text(
        userName,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: Colors.grey,
        ),
      ),
      subtitle: Text(
        message,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
      isThreeLine: true,
    );
  }
}
