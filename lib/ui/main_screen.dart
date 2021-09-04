import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_taking_app/constants/text_and_decorations(methods).dart';
import 'package:note_taking_app/ui/adding_notes.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: titleText,
        backwardsCompatibility: false,
        backgroundColor: Colors.white.withOpacity(0.4),
      ),
      floatingActionButton: Container(
        height: 80.0,
        width: 80.0,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddingNotes()));
            },
            child: const Icon(
              Icons.add,
            ),
            backgroundColor: Colors.green,
          ),
        ),
      ),
      body: Container(
        color: Colors.white.withOpacity(0.4),
      ),
    );
  }
}
