import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_taking_app/constants/buttons_and_icons_misc(classes).dart';
import 'package:note_taking_app/db/db_operations.dart';
import 'package:note_taking_app/db/model_notes.dart';
import 'package:sqflite/sqflite.dart';

import 'main_screen.dart';

final bodyController = TextEditingController();
final headerController = TextEditingController();
final dbHelper = DatabaseHelper.instance;

class AddingNotes extends StatefulWidget {
  @override
  _AddingNotesState createState() => _AddingNotesState();
}

class _AddingNotesState extends State<AddingNotes> {

  @override
  void dispose() {
    //bodyController.dispose();
    //headerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backwardsCompatibility: true,
        leading: LeadingIcon(
          callBack: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white.withOpacity(0.4),
        actions: <Widget>[
          ActionsIconButton(
            icon: Icon(undo, color: black),
            callBack: () {
              debugPrint('undo tapped');
            },
          ),
          ActionsIconButton(
            icon: Icon(redo, color: black),
            callBack: () {
              debugPrint('redo tapped');
            },
          ),
          ActionsIconButton(
            icon: Icon(save, color: black),
            callBack: () async {
              debugPrint(bodyController.text);
              debugPrint(headerController.text);
              getHeaderDataToMainScreen(context);
              //insertNote(note);
              String title = headerController.text;
              String body =  bodyController.text;
              //dbHelper.insert(title, body);
              //_insert(title, body);
              Note note = Note(20, title, body);

              var value = await dbHelper.insert(note);
              print("if 1 is return then insert success and 0 then not inserted : $value");
            },
          )
        ],
      ),
      body: Container(
        color: Colors.white.withOpacity(0.4),
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Column(
            children: [
              HeaderBody(
                textEditingController: headerController,
              ),
              SizedBox(
                height: 32.0,
              ),
              Expanded(
                child: NotesBody(
                  textEditingController: bodyController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

getHeaderDataToMainScreen(BuildContext context){
  Navigator.push(context,
      MaterialPageRoute(
        builder: (context) => MainScreen(
          heading : headerController.text,
        )
      )
  );
}


