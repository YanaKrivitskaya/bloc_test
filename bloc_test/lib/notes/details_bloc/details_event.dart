import 'package:bloctest/notes/note.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class DetailsEvent extends Equatable{
  const DetailsEvent();
  @override
  List<Object> get props => [];
}

class GetNoteDetails extends DetailsEvent{
  final String noteId;

  GetNoteDetails(this.noteId);

  @override
  List<Object> get props => [noteId];
}

class NewNoteMode extends DetailsEvent{}

class EditMode extends DetailsEvent{
  final Note note;

  EditMode(this.note);

  @override
  List<Object> get props => [note];
}

