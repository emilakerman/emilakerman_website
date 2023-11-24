import 'package:emilakerman_website/constant_links.dart';
import 'package:emilakerman_website/text_field_history.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;

class CustomTerminal extends StatefulWidget {
  const CustomTerminal({super.key});

  @override
  State<CustomTerminal> createState() => _CustomTerminalState();
}

class _CustomTerminalState extends State<CustomTerminal> {
  final TextEditingController _textFieldController = TextEditingController();
  FocusNode myFocusNode = FocusNode();

  void saveTextAndDisplayInTerminal(String text) {
    setState(() {
      history.add(text);
    });
    checkInput(text);
  }

  void checkInput(String text) {
    switch (text) {
      case 'clear':
        setState(() => history.clear());
      case 'cd':
        print('opened folder!');
      case 'ls':
        print('showing contents of folder!');
        setState(() => history = history + rootFolders);
      case 'mkdir':
        print('created folder!');
      case 'help':
        setState(
          () => history.add(
            'eShell: available commands: clear, ls, help, open github, open linkedin',
          ),
        );
      case 'open github':
        _openLink(ConstantLinks.github);
      case 'open linkedin':
        _openLink(ConstantLinks.linkedin);
      default:
        setState(() => history.add('eShell: command not found: $text'));
    }
  }

  void _openLink(String destination) {
    html.window.open(
      destination,
      destination,
    );
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
