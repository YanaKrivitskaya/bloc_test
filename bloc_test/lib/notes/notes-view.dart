import 'package:bloctest/constants.dart';
import 'package:bloctest/notes/note.dart';
import 'package:bloctest/notes/notes_bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bloctest/shared/shared.dart';

class NotesView extends StatefulWidget {
  @override
  _NotesViewState createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<NotesBloc, NotesState>(
      listener: (context, state) {},
      child: BlocBuilder<NotesBloc, NotesState>(
          bloc: BlocProvider.of(context),
          builder: (context, state) {
            if (state is NotesEmpty || state is NotesLoadInProgress) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is NotesLoadSuccess) {
              final notes = _sortNotes(state.notes, state.sortField);
              return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: notes.length,
                  reverse:
                      state.sortDirection == SortDirections.ASC ? true : false,
                  itemBuilder: (context, position) {
                    final note = notes[position];
                    return Card(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.description, size: 40.0),
                            title: Text('${note.title}'),
                            subtitle: (note.dateCreated.day
                                        .compareTo(note.dateModified.day) ==
                                    0)
                                ? Text(
                                    '${DateFormat.yMMMd().format(note.dateModified)}')
                                : Text(
                                    '${DateFormat.yMMMd().format(note.dateModified)} / ${DateFormat.yMMMd().format(note.dateCreated)}',
                                  ),
                            trailing: _popupMenu(note, position),
                            onTap: () {
                              Navigator.pushNamed(context, noteDetailsRoute,
                                  arguments: note.id);
                            },
                          ),
                        ],
                      ),
                    );
                  });
            }
            return const Empty();
          }),
    );
  }

  List<Note> _sortNotes(List<Note> notes, SortFields sortOption) {
    notes.sort((a, b) {
      switch (sortOption) {
        case SortFields.DATECREATED:
          {
            return a.dateCreated.millisecondsSinceEpoch
                .compareTo(b.dateCreated.millisecondsSinceEpoch);
          }
        case SortFields.DATEMODIFIED:
          {
            return a.dateModified.millisecondsSinceEpoch
                .compareTo(b.dateModified.millisecondsSinceEpoch);
          }
        case SortFields.TITLE:
          {
            return a.title.toUpperCase().compareTo(b.title.toUpperCase());
          }
      }
      return a.title.compareTo(b.title);
    });
    return notes;
  }

  Widget _popupMenu(Note note, int position) => PopupMenuButton<int>(
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 2,
            child: Text("Delete"),
          ),
        ],
        onSelected: (value) async {
          if (value == 2) {
            final result = await _deleteAlert(note);
          }
          print("value:$value");
        },
      );

  Future<String> _deleteAlert(Note note) async {
    return showDialog<String>(
      context: context, // you need to use this context to get the bloc
      barrierDismissible: false, // user must tap button!
      builder: (_) {
        // this dialog context(_) is different than the one above and won't find your bloc since it's basically a new route; any dialog gets pushed onto a new route.
        return AlertDialog(
          title: Text('Delete note?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('${note.title}'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Delete'),
              onPressed: () {
                context.bloc<NotesBloc>().add(DeleteNote(note));
                Navigator.pop(context, "Delete");
              },
            ),
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context, "Cancel");
              },
            ),
          ],
        );
      },
    );
  }
}
