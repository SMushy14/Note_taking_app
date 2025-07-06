import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/notes_cubit.dart';

class AddEditNoteDialog extends StatefulWidget {
  final User user;
  final Map<String, dynamic>? existingNote;

  const AddEditNoteDialog({super.key, required this.user, this.existingNote});
  @override
  State<AddEditNoteDialog> createState() => _AddEditNoteDialogState();
}

class _AddEditNoteDialogState extends State<AddEditNoteDialog> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(
      text: widget.existingNote?['text'] ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.existingNote == null ? 'Add Note' : 'Edit Note'),
      content: TextField(controller: controller, autofocus: true),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            if (widget.existingNote == null) {
              await context.read<NotesCubit>().addNote(
                widget.user.uid,
                controller.text,
              );
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Note added successfully")),
              );
            } else {
              await context.read<NotesCubit>().updateNote(
                widget.existingNote!['id'],
                controller.text,
                widget.user.uid,
              );
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Note updated successfully")),
              );
            }
            if (!context.mounted) return;
            Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
