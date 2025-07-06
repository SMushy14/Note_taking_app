import 'package:cloud_firestore/cloud_firestore.dart';

class NotesRepository {
  final _notes = FirebaseFirestore.instance.collection('notes');

  Future<List<Map<String, dynamic>>> fetchNotes(String uid) async {
    final snap = await _notes.where('uid', isEqualTo: uid).get();
    return snap.docs.map((e) => {...e.data(), 'id': e.id}).toList();
  }

  Future<void> addNote(String uid, String text) async {
    await _notes.add({'uid': uid, 'text': text, 'timestamp': DateTime.now()});
  }

  Future<void> updateNote(String id, String text) async {
    await _notes.doc(id).update({'text': text});
  }

  Future<void> deleteNote(String id) async {
    await _notes.doc(id).delete();
  }
}
