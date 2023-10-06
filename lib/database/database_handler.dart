import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:notes_app/models/note_model.dart';

class DatabaseHanlder {
  static Future<void> createNote(NoteModel note) async {
    final noteCollection = FirebaseFirestore.instance.collection("notes");
    final id = noteCollection.doc().id;
    final newNote =
        NoteModel(id: id, title: note.title, body: note.body, color: note.color)
            .toDocument();

    try {
      noteCollection.doc(id).set(newNote);
    } catch (e) {
      if (kDebugMode) {
        print("Error ocurrs $e");
      }
    }
  }

  static Stream<List<NoteModel>> getNotes() {
    final noteCollection = FirebaseFirestore.instance.collection("notes");
    return noteCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => NoteModel.fromSnapshot(e)).toList());
  }

  static Future<void> updateNote(NoteModel note) async {
    final noteCollection = FirebaseFirestore.instance.collection("notes");
    final notetoUpdate = NoteModel(
            id: note.id, title: note.title, body: note.body, color: note.color)
        .toDocument();

    try {
      await noteCollection.doc(note.id).update(notetoUpdate);
    } catch (e) {
      if (kDebugMode) {
        print("Error ocurrs $e");
      }
    }
  }

  static Future<void> deleteNote(String id) async {
    final noteCollection = FirebaseFirestore.instance.collection("notes");
    print(noteCollection);
    try {
      await noteCollection.doc(id).delete();
    } catch (e) {
      if (kDebugMode) {
        print("Error ocurrs $e");
      }
    }
  }
}
