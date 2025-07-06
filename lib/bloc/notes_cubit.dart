import 'package:bloc/bloc.dart';
import '../data/notes_repository.dart';

class NotesState {
  final List<Map<String, dynamic>> notes;
  final bool isLoading;
  final String? error;
  final String? successMessage;

  NotesState({
    this.notes = const [],
    this.isLoading = false,
    this.error,
    this.successMessage,
  });

  NotesState copyWith({
    List<Map<String, dynamic>>? notes,
    bool? isLoading,
    String? error,
    String? successMessage,
  }) {
    return NotesState(
      notes: notes ?? this.notes,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      successMessage: successMessage,
    );
  }
}

class NotesCubit extends Cubit<NotesState> {
  final NotesRepository notesRepo;

  NotesCubit(this.notesRepo) : super(NotesState());

  Future<void> fetchNotes(String userId) async {
    emit(state.copyWith(isLoading: true, error: null, successMessage: null));
    try {
      final notes = await notesRepo.fetchNotes(userId);
      emit(state.copyWith(notes: notes, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: 'Failed to fetch notes', isLoading: false));
    }
  }

  Future<void> addNote(String userId, String text) async {
    emit(state.copyWith(isLoading: true, error: null, successMessage: null));
    try {
      await notesRepo.addNote(userId, text);
      final updatedNotes = await notesRepo.fetchNotes(userId);
      emit(
        state.copyWith(
          notes: updatedNotes,
          isLoading: false,
          successMessage: 'Note added successfully',
        ),
      );
    } catch (e) {
      emit(state.copyWith(error: 'Failed to add note', isLoading: false));
    }
  }

  Future<void> updateNote(String noteId, String text, String userId) async {
    emit(state.copyWith(isLoading: true, error: null, successMessage: null));
    try {
      await notesRepo.updateNote(noteId, text);
      final updatedNotes = await notesRepo.fetchNotes(userId);
      emit(
        state.copyWith(
          notes: updatedNotes,
          isLoading: false,
          successMessage: 'Note updated successfully',
        ),
      );
    } catch (e) {
      emit(state.copyWith(error: 'Failed to update note', isLoading: false));
    }
  }

  Future<void> deleteNote(String noteId, String userId) async {
    emit(state.copyWith(isLoading: true, error: null, successMessage: null));
    try {
      await notesRepo.deleteNote(noteId);
      final updatedNotes = await notesRepo.fetchNotes(userId);
      emit(
        state.copyWith(
          notes: updatedNotes,
          isLoading: false,
          successMessage: 'Note deleted successfully',
        ),
      );
    } catch (e) {
      emit(state.copyWith(error: 'Failed to delete note', isLoading: false));
    }
  }
}
