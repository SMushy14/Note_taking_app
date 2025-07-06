import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/notes_repository.dart';

class NotesState {
  final List<Map<String, dynamic>> notes;
  final bool isLoading;
  final String? error;
  NotesState({required this.notes, this.isLoading = false, this.error});
}

class NotesCubit extends Cubit<NotesState> {
  final NotesRepository notesRepo;
  NotesCubit(this.notesRepo) : super(NotesState(notes: []));

  Future<void> fetchNotes(String uid) async {
    emit(NotesState(notes: [], isLoading: true));
    try {
      final notes = await notesRepo.fetchNotes(uid);
      emit(NotesState(notes: notes));
    } catch (e) {
      emit(NotesState(notes: [], error: e.toString()));
    }
  }

  Future<void> addNote(String uid, String text) async {
    await notesRepo.addNote(uid, text);
    await fetchNotes(uid);
  }

  Future<void> updateNote(String id, String text, String uid) async {
    await notesRepo.updateNote(id, text);
    await fetchNotes(uid);
  }

  Future<void> deleteNote(String id, String uid) async {
    await notesRepo.deleteNote(id);
    await fetchNotes(uid);
  }
}
