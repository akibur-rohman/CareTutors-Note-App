import '../model/note_model.dart';

abstract class NotesRepository {
  Stream<List<NoteModel>> getNotesStream(String userId);
  Future<void> addNote(NoteModel note);
  Future<void> updateNote(NoteModel note);
  Future<void> deleteNote(String id);
}
