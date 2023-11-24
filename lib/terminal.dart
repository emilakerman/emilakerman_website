import 'package:emilakerman_website/text_field_history.dart';
import 'package:flutter/material.dart';

class CustomTerminal extends StatefulWidget {
  const CustomTerminal({super.key});

  @override
  State<CustomTerminal> createState() => _CustomTerminalState();
}

class _CustomTerminalState extends State<CustomTerminal> {
  final TextEditingController _textFieldController = TextEditingController();
  FocusNode myFocusNode = FocusNode();

  void saveTextAndDisplayInTerminal(String text) {
    checkInput(text);
    setState(() {
      history.add(text);
    });
  }

  void checkInput(String text) {
    switch (text) {
      case 'cd':
        print('opened folder!');
      case 'ls':
        print('showing contents of folder!');
      case 'mkdir':
        print('created folder!');
      default:
        print('uknown command!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 96, 88, 88),
        body: Center(
          child: Container(
            width: 600,
            height: 300,
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _buildHistoryList(),
                  TextField(
                    controller: _textFieldController,
                    focusNode: myFocusNode,
                    onSubmitted: (value) {
                      saveTextAndDisplayInTerminal(value);
                      _textFieldController.clear();
                      myFocusNode.requestFocus();
                    },
                    showCursor: false,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: '>',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryList() {
    return Expanded(
      child: ListView.builder(
        itemCount: history.length,
        itemBuilder: (_, index) => Text(
          history[index],
          textAlign: TextAlign.left,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
