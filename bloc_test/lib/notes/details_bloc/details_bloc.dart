import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloctest/notes/note.dart';
import 'package:bloctest/notes/repo/note_repository.dart';
import 'package:meta/meta.dart';

import './bloc.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final NoteRepository _notesRepository;

  DetailsBloc({@required NoteRepository notesRepository})
      : assert(notesRepository != null),
        _notesRepository = notesRepository;

  @override
  DetailsState get initialState => InitialDetailsState();

  @override
  Stream<DetailsState> mapEventToState(
    DetailsEvent event,
  ) async* {
    if (event is GetNoteDetails) {
      yield* _mapGetNoteDetailsToState(event);
    } else if (event is NewNoteMode) {
      yield* _mapNewNoteModeToState(event);
      // you were checking state here instead of event so your event wasn't being processed :)
    } else if (event is EditMode) {
      yield* _mapEditModeToState(event);
    }
  }

  Stream<DetailsState> _mapGetNoteDetailsToState(GetNoteDetails event) async* {
    Note note = await _notesRepository.getNoteById(event.noteId);

    yield ViewDetailsState(note);
  }

  Stream<DetailsState> _mapNewNoteModeToState(NewNoteMode event) async* {
    yield EditDetailsState(new Note(''), true);
  }

  Stream<DetailsState> _mapEditModeToState(EditMode event) async* {
    yield EditDetailsState(event.note, true);
  }
}
