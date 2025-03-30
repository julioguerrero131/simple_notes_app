import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_notes_app/modules/note.dart';
import 'package:simple_notes_app/modules/note_database.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  // access to what the user typed
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // fetch existing notes at app startup
    readNotes();
  }

  // create a note
  void createNote() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            content: TextField(controller: textController),
            actions: [
              // create button
              MaterialButton(
                onPressed: () {
                  // add to db
                  context.read<NoteDatabase>().addNote(textController.text);
                  // clear controller
                  textController.clear();
                  // pop dialog box
                  Navigator.pop(context);
                },
                child: const Text("Create"),
              ),
            ],
          ),
    );
  }

  // read a note
  void readNotes() {
    context.read<NoteDatabase>().fetchNotes();
  }

  // update a note
  // delete a note

  @override
  Widget build(BuildContext context) {
    // notes database
    final noteDatabase = context.watch<NoteDatabase>();

    // current notes
    List<Note> currentNotes = noteDatabase.currentNotes;

    return Scaffold(
      appBar: AppBar(title: Text("Notes")),
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: currentNotes.length,
        itemBuilder: (context, index) {
          // get individual note
          final note = currentNotes[index];
          // list tile ui
          return ListTile(
            title: Text(note.text),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // edit button

                // delete button
                
              ],
            ),
          );
        }
      ),
    );
  }
}
