import 'package:bloctest/constants.dart';
import 'package:bloctest/notes/details_bloc/bloc.dart';
import 'package:bloctest/notes/note-detail-view.dart';
import 'package:bloctest/notes/note-page.dart';
import 'package:bloctest/notes/repo/firebase_notes_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;

    switch(settings.name){
      case notesRoute: return MaterialPageRoute(builder: (_) => NotesPage());
      case noteDetailsRoute: {
        if(args is String){
          return MaterialPageRoute(builder: (_) =>
              BlocProvider<DetailsBloc>(
                create: (context) => DetailsBloc(notesRepository: FirebaseNotesRepository()),
                child: NoteDetailsView(noteId: args),
              ));
        }
        return _errorRoute();
      }

      default: return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Oops'),
        ),
        body: Center(
          child: Text('Something went wrong'),
        ),
      );
    });
  }

}