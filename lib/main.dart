import 'package:app_catatan/models/note.dart';
import 'package:app_catatan/screens/notes_from_screen.dart';
import 'package:app_catatan/screens/notes_list_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter SQLite',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: const NotesListScreen(),
      onGenerateRoute: (settings) {
        if (settings.name == '/form') {
          final note = settings.arguments as Note?;
          return MaterialPageRoute(builder: (_) => NotesFromScreen(note: note));
        }
        return null;
      },
    );
  }
}
