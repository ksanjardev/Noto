import 'package:my_notes_eslatma_ilovasi/data/model/note_model/notedata.dart';

abstract class NoteRepository{
  Future<bool> addNote(String title,String description);
  Future<bool> editNote(NoteData notedata);
  Future<bool> deleteNote(String id);
  Stream<List<NoteData>> getNotes();
}