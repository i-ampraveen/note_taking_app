import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_taking_app/constants/classes.dart';
import 'package:note_taking_app/constants/methods.dart';
import 'package:note_taking_app/utils/model_notes.dart';
import 'package:note_taking_app/ui/add notes.dart';
import 'package:toast/toast.dart';

import 'edit notes.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Note> noteList = [];

  @override
  void initState() {
    super.initState();
    dbHelper.initDatabase();
    setNotesFromDB();
  }

  setNotesFromDB() async {
    print("Entered setNotes in main page");
    var fetchedNotes = await dbHelper.getNotesFromDB();
    setState(() {
      noteList = fetchedNotes;
    });
  }

  removeNotesFromDB(int id) async {
    print("Removing notes in main page");
    await dbHelper.delete(id);
    setNotesFromDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainScreenAppBar,
      floatingActionButton: FAB(
        whatToDo: () {
          gotoAddingNotesPage(context);
        },
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: noteList.length,
          itemBuilder: (context, index) {
            final note = noteList[index];
            return Dismissible(
              key: Key((note.id).toString()),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                setState(() {
                  noteList.removeAt(index);
                  removeNotesFromDB(note.id);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Note deleted"),
                    action: SnackBarAction(
                      label: "UNDO",
                      onPressed: () {
                        setState(() {
                          dbHelper.insert(note);
                          setNotesFromDB();
                        });
                        Toast.show(
                            "Restored note is available at the end of the list",
                            context,
                            duration: Toast.LENGTH_LONG,
                            gravity: Toast.BOTTOM);
                      },
                    ),
                  ),
                );
              },
              background: Delete(),
              child: TileCard(
                titleText: ('${noteList[index].title}'),
                dateText: ('${noteList[index].date}'),
                whatToDoOnPressed: () async {
                  int getIDOfTheUserClickedNote = (noteList[index].id);
                  debugPrint('before navigating to editing notes');
                  Navigator.of(context)
                      .push(
                        MaterialPageRoute(
                          builder: (context) =>
                              EditingNotes(getIDOfTheUserClickedNote),
                        ),
                      )
                      .then((value) => setState(() {
                            setNotesFromDB();
                          }));
                  debugPrint('after navigating to editing notes');
                  debugPrint('${noteList[index].id}');
                },
              ),
            );
          },
        ),
      ),
    );
  }

  gotoAddingNotesPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddingNotes(),
      ),
    ).then((value) => setState(() {
          setNotesFromDB();
        }));
  }
}
