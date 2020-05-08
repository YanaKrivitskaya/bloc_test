import 'dart:async';

import 'package:bloctest/notes/details_bloc/bloc.dart';
import 'package:bloctest/notes/details_bloc/details_bloc.dart';
import 'package:bloctest/notes/note.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteDetailsView extends StatefulWidget {
  NoteDetailsView({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _NotesDetailsViewState();
  }
}

class _NotesDetailsViewState extends State<NoteDetailsView> {
  TextEditingController _titleController;
  TextEditingController _textController;

  @override
  Widget build(BuildContext context) {
    return BlocListener<DetailsBloc, DetailsState>(
      listener: (context, state) {},
      child: BlocBuilder<DetailsBloc, DetailsState>(builder: (context, state) {
        if (state is ViewDetailsState) {
          final _note = state.note;
          return new Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                actions: <Widget>[
                  _editAction(state),
                  _deleteAction(_note, context),
                ],
              ),
              body: Container(
                  padding: EdgeInsets.only(bottom: 65.0),
                  child: Column(children: <Widget>[
                    _titleViewCard(_note),
                    _textViewCard(_note),
                  ])));
        }
        if (state is EditDetailsState) {
          final _note = state.notetoEdit;
// todo -- TextEditingControllers should be initialized in initState of a stateful widget or else when the widget is rebuilt you'll keep getting new ones created
// todo -- override dispose method and dispose these controllers
          _titleController = new TextEditingController(text: _note.title);
          _textController = new TextEditingController(text: _note.text);
          return new Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                actions: <Widget>[
                  _saveAction(state),
                  _deleteAction(_note, context),
                ],
              ),
              body: Container(
                  padding: EdgeInsets.only(bottom: 65.0),
                  child:
                      Column(children: <Widget>[_titleCard(), _textCard()])));
        }
        return Container();
      }),
    );
  }

  Widget _editAction(DetailsState state) => new IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          if (state is ViewDetailsState) {
            context.bloc<DetailsBloc>().add(EditMode(state.note));
          }
        },
      );

  Widget _titleViewCard(Note note) => new Card(
      child: Padding(
          padding: EdgeInsets.all(5.0),
          child: ListTile(
            title: Text('${note.title}',
                style: new TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(
              'Created: ${DateFormat.yMMMd().format(note.dateCreated)} | Modified: ${DateFormat.yMMMd().format(note.dateModified)}',
            ),
          )));

  Widget _textViewCard(Note note) => new Expanded(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Card(
                  child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: ListTile(
                          title: Text('${note.text}'),
                          contentPadding: EdgeInsets.all(10.0))))
            ],
          ),
        ),
      );

  Widget _titleCard() => new Card(
      child: Padding(
          padding: EdgeInsets.only(bottom: 15.0, right: 15.0, left: 15.0),
          child: _titleTextField()));

  Widget _titleTextField() => new TextFormField(
      decoration: const InputDecoration(
        labelText: 'Title',
      ),
      controller: _titleController,
      keyboardType: TextInputType.text);

  Widget _textCard() => new Expanded(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Card(
                  child: Padding(
                      padding: EdgeInsets.only(
                          bottom: 15.0, right: 15.0, left: 15.0),
                      child: _textTextField()))
            ],
          ),
        ),
      );

  Widget _textTextField() => new TextFormField(
        decoration: const InputDecoration(
          labelText: 'Note text comes here',
        ),
        controller: _textController,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        autofocus: true,
      );

  Widget _saveAction(DetailsState state) => new IconButton(
        icon: Icon(Icons.save),
        onPressed: () {
          //_editNote(note);
        },
      );

  Widget _deleteAction(Note note, BuildContext context) => new IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          /*_deleteAlert(note).then((res){
        if(res == "Delete") Navigator.of(context).pop();
      });*/
        },
      );
}
