import 'dart:async';

import 'package:bloctest/notes/note.dart';

abstract class NoteRepository {

  Stream<List<Note>> notes();

  Future<Note> getNoteById(String id);
}