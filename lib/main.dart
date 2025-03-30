import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_notes_app/modules/note_database.dart';
import 'package:simple_notes_app/pages/notes_page.dart';

void main() async {
  // initialize notes database
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initialize();

  runApp(
    ChangeNotifierProvider(
      create: (context) => NoteDatabase(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotesPage(),
    );
  }
}
