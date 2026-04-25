import 'package:app_catatan/helper/database_helper.dart';
import 'package:app_catatan/models/note.dart';
import 'package:flutter/material.dart';

class NotesListScreen extends StatefulWidget {
  const NotesListScreen({super.key});

  @override
  State<NotesListScreen> createState() => _NotesListScreenState();
}

class _NotesListScreenState extends State<NotesListScreen> {
  List<Note> _notes = [];

  @override
  void initState(){
    super.initState();
    _refreshNotes();
  }
  
  Future<void> _refreshNotes() async {
    final notes = await DatabaseHelper.instance.getAll();
    setState(() {
      _notes = notes;
    });
  
  }


  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}