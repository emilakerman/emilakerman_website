import 'package:emilakerman_website/terminal.dart';
import 'package:flutter/material.dart';
import 'package:simple_icons/simple_icons.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

void main() {
  runApp(CustomTerminal());
}

class MyApp extends StatefulWidget {
  bool displayPDF;
  MyApp({super.key, required this.displayPDF});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 59, 55, 39),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildIconButton(icon: Icons.edit_document, isGithub: false),
              widget.displayPDF
                  ? const SizedBox.shrink()
                  : _buildIconButton(
                      icon: SimpleIcons.github,
                      destination: 'https://github.com/emilakerman',
                      isGithub: true,
                    ),
              widget.displayPDF ? _showCV() : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _showCV() {
    return const Expanded(
      child: Image(
        image: NetworkImage('assets/cv_for_website.png'),
      ),
    );
  }

  void showPDF() {
    setState(() {
      widget.displayPDF = !widget.displayPDF;
    });
  }

  Widget _buildIconButton({
    required IconData icon,
    String? destination,
    required bool isGithub,
  }) {
    return IconButton(
      onPressed: () => isGithub
          ? html.window.open(
              destination!,
              destination,
            )
          : showPDF(),
      icon: Icon(
        icon,
        size: 80,
        color: Colors.amberAccent,
      ),
    );
  }
}
