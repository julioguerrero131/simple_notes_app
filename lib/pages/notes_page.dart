import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simple_notes_app/components/drawer.dart';
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
  void updateNote(Note note) {
    // prefill current note text
    textController.text = note.text;
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("Update Note"),
            content: TextField(controller: textController),
            actions: [
              // update button
              MaterialButton(
                onPressed: () {
                  // update note in db
                  context.read<NoteDatabase>().updateNote(
                    note.id,
                    textController.text,
                  );
                  // clear controller
                  textController.clear();
                  // pop dialog box
                  Navigator.pop(context);
                },
                child: const Text("Update"),
              ),
            ],
          ),
    );
  }

  // delete a note
  void deleteNote(int id) {
    context.read<NoteDatabase>().deleteNote(id);
  }

  @override
  Widget build(BuildContext context) {
    // notes database
    final noteDatabase = context.watch<NoteDatabase>();

    // current notes
    List<Note> currentNotes = noteDatabase.currentNotes;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        child: const Icon(Icons.add),
      ),
      drawer: const MyDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              "Notes",
              style: GoogleFonts.dmSerifText(
                fontSize: 48,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
          // List of Notes
          Expanded(
            child: ListView.builder(
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
                      IconButton(
                        onPressed: () => updateNote(note),
                        icon: const Icon(Icons.edit),
                      ),
                      // delete button
                      IconButton(
                        onPressed: () => deleteNote(note.id),
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
