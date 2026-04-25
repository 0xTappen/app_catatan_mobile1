import 'package:app_catatan/helper/database_helper.dart';
import 'package:app_catatan/models/note.dart';
import 'package:flutter/material.dart';

class NotesFromScreen extends StatefulWidget {
  final Note? note;
  
  NotesFromScreen({this.note});

  @override
  State<NotesFromScreen> createState() => _NotesFromScreenState();
}

class _NotesFromScreenState extends State<NotesFromScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleCtrl;
  late TextEditingController _contentCtrl;

  bool get isEditing => widget.note != null;

  @override
  void initState() {
    super.initState();
    _titleCtrl = TextEditingController(text: widget.note?.title ?? '');
    _contentCtrl = TextEditingController(text: widget.note?.content ?? '');
  }

  Future<void> _saveNote() async {
    if (_formKey.currentState!.validate()) {
      final note = Note(
        id: widget.note?.id,
        title: _titleCtrl.text,
        content: _contentCtrl.text,
        createdAt: DateTime.now().toIso8601String(),
      );
      if (isEditing) {
        await DatabaseHelper.instance.update(note);
      } else {
        await DatabaseHelper.instance.insert(note);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Catatan' : 'Tambah Catatan')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleCtrl,
                decoration: const InputDecoration(labelText: 'Judul'),
                validator: (v) => v!.isEmpty ? 'Judul tidak boleh kosong' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _contentCtrl,
                decoration: const InputDecoration(labelText: 'Isi'),
                maxLines: 4,
                validator: (v) => v!.isEmpty ? 'Isi tidak boleh kosong' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveNote,
                child: Text(isEditing ? 'Update' : 'Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}