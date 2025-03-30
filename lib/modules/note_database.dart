import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_notes_app/modules/note.dart';

class NoteDatabase extends ChangeNotifier {
  static late Isar isar;

  // initialize database
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [NoteSchema],
      directory: dir.path,
    );
  }

  // list of notes
  final List<Note> currentNotes = [];
  
  // create
  Future<void> addNote(String textFromUser) async {
    // create a new note object
    final newNote = Note()..text = textFromUser;
    // save to db
    await isar.writeTxn(() => isar.notes.put(newNote));
    // re-read from db
    fetchNotes();
  }

  // read
  Future<void> fetchNotes() async {
    // get all notes
    List<Note> fetchNotes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchNotes);
    // notify widgets that are listening
    notifyListeners();
  }

  // update
  Future<void> updateNote(int id, String newText) async {
    final existingNote = await isar.notes.get(id);

    if (existingNote != null) {
      existingNote.text = newText;
      await isar.writeTxn(() => isar.notes.put(existingNote));
      // re-read db
      fetchNotes();
    }
  }

  // delete
  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
    // re-read db
    fetchNotes();
  }
}