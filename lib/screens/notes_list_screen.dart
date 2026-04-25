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

  Future<void> _deleteNote(int id) async {
    await DatabaseHelper.instance.delete(id);
    _refreshNotes();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Catatan berhasil dihapus")));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Catatan")),
        body: _notes.isEmpty
          ? const Center(child: Text('Belum ada catatan'))
          : ListView.builder(
              itemCount: _notes.length,
              itemBuilder: (context, index) {
                final note = _notes[index];
                return ListTile(
                  title: Text(note.title),
                  subtitle: Text(note.content, maxLines: 1, overflow: TextOverflow.ellipsis),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteNote(note.id!),
                  ),
                  onTap: () async {
                    await Navigator.pushNamed(context, '/form', arguments: note);
                    _refreshNotes();
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.pushNamed(context, '/form');
          _refreshNotes();
        },
      ),
    );
  }
}