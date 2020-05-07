import 'package:bloctest/notes/note.dart';
import 'package:meta/meta.dart';

@immutable
class DetailsState {
  const DetailsState();

  @override
  List<Object> get props => [];
}

class InitialDetailsState extends DetailsState {}

class ViewDetailsState extends DetailsState {
  final Note note;

  const ViewDetailsState(this.note);

  @override
  List<Object> get props => [note];
}

class EditDetailsState extends DetailsState {
  final Note notetoEdit;
  final bool isEdit;

  const EditDetailsState(this.notetoEdit, this.isEdit);
  @override
  List<Object> get props => [notetoEdit, isEdit];
}

class AddNoteState extends DetailsState {
  final Note note;
  const AddNoteState(this.note);
  @override
  List<Object> get props => [note];
}

class LoadingDetailsState extends DetailsState {}
