import 'package:bloctest/constants.dart';
import 'package:bloctest/notes/notes-view.dart';
import 'package:bloctest/notes/notes_bloc/notes_bloc.dart';
import 'package:bloctest/notes/repo/firebase_notes_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotesPage extends StatelessWidget{
  NotesPage();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotesBloc>(
      create: (context) => NotesBloc(notesRepository: FirebaseNotesRepository()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Notes'),
          centerTitle: true,
        ),
        body:  NotesView(),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.pushNamed(context, noteDetailsRoute, arguments: '');
          },
          tooltip: 'Add New Note',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}