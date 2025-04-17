import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_notes_eslatma_ilovasi/data/local/local_storage.dart';
import 'package:my_notes_eslatma_ilovasi/data/model/note_model/notedata.dart';
import 'package:my_notes_eslatma_ilovasi/data/repository/note_repository.dart';
import 'package:uuid/uuid.dart';

class NoteRepositoryImpl extends NoteRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _uuid = Uuid();

  @override
  Future<bool> addNote(String title, String description) async {
    try {
      final userName = await getUserId();
      final userDoc = await _firestore
          .collection("Users")
          .where("name", isEqualTo: userName)
          .get();
      final docRef = userDoc.docs.first.reference;
      final note = NoteData(_uuid.v4(), title, description, DateTime.now());
      await docRef.update({
        'notes': FieldValue.arrayUnion([note.toJson()])
      });
      return true;
    } catch (e) {
      print("Add note error $e");
      return false;
    }
  }

  @override
  Future<bool> deleteNote(String id) async {
    try {
      final userName = await getUserId();
      final userDoc = await _firestore
          .collection("Users")
          .where("name", isEqualTo: userName)
          .get();
      final docRef = userDoc.docs.first.reference;
      final data = userDoc.docs.first.data();
      final notes = (data['notes'] as List)
          .map((e) => NoteData.fromJson(Map<String, dynamic>.from(e)))
          .toList();
      final filteredNotes = notes.where((note) => note.id != id).toList();
      await docRef
          .update({'notes': filteredNotes.map((n) => n.toJson()).toList()});
      return true;
    } catch (e) {
      print("delete note error $e");
      return false;
    }
  }

  @override
  Future<bool> editNote(NoteData notedata) async {
    try {
      final userName = await getUserId();
      final userDoc = await _firestore
          .collection("Users")
          .where("name", isEqualTo: userName)
          .get();
      final DocumentReference<Map<String, dynamic>> docRef =
          userDoc.docs.first.reference;
      final data = userDoc.docs.first.data();
      final List<NoteData> notes = (data['notes'] as List)
          .map((e) => NoteData.fromJson(Map<String, dynamic>.from(e)))
          .toList();
      final List<NoteData> updateNotes = notes.map((note) {
        return note.id == notedata.id ? notedata : note;
      }).toList();
      await docRef
          .update({'notes': updateNotes.map((n) => n.toJson()).toList()});
      return true;
    } catch (e) {
      print("Edit note error $e");
      return false;
    }
  }

  @override
  Stream<List<NoteData>> getNotes() {
    return Stream.fromFuture(getUserId()).asyncExpand((userName) {
      return _firestore
          .collection("Users")
          .where('name', isEqualTo: userName)
          .snapshots()
          .map((snapshot) {
        if (snapshot.docs.isEmpty) return [];
        final noteJson = snapshot.docs.first['notes'] as List<dynamic>;
        return noteJson
            .map((e) => NoteData.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      });
    });
  }
}
