
import 'dart:async';

import 'package:bloctest/notes/note.dart';
import 'package:bloctest/notes/repo/note_repository.dart';


class FirebaseNotesRepository extends NoteRepository{


  FirebaseNotesRepository() {}

  @override
  Future<Note> getNoteById(String id) async {
    return Note("test", title: "test", id: "1234546", dateCreated: DateTime.now(), dateModified: DateTime.now());
  }

  @override
  Stream<List<Note>> notes() async* {

    List<Note> notes = new List<Note>();
    Duration interval = new Duration(seconds:1);

    int i = 0;

    while(i<5){
      await Future.delayed(interval);
      notes.add(
          Note("test note", title: "test123", id: "1234546", dateCreated: DateTime.now(), dateModified: DateTime.now())
      );
      i++;
      yield notes;
    }
  }
}