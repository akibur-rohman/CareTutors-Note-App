import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/model/note_model.dart';
import '../../domain/repository/notes_repository.dart';

class FirestoreNotesRepository implements NotesRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference get _notesCollection => _firestore.collection('notes');

  @override
  Stream<List<NoteModel>> getNotesStream(String userId) {
    return _notesCollection
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      final list = snapshot.docs.map((doc) {
        return NoteModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
      // Sort in-memory by creation date descending to bypass composite index requirement
      list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return list;
    });
  }

  @override
  Future<void> addNote(NoteModel note) async {
    await _notesCollection.add(note.toMap());
  }

  @override
  Future<void> updateNote(NoteModel note) async {
    await _notesCollection.doc(note.id).update(note.toMap());
  }

  @override
  Future<void> deleteNote(String id) async {
    await _notesCollection.doc(id).delete();
  }
}
