import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:notes_assignment/database/sqf_lite.dart';
import 'package:notes_assignment/models/notes_model.dart';

part 'notes_event.dart';

class NotesBloc extends Bloc<NotesEvents, List<NotesModel>> {
  SQFliteDatabase sqFliteDatabase = SQFliteDatabase.instance;
  NotesBloc() : super([]) {
  on<FetchNotesEvent>((event, emit) async {
   try {
      final List<Map<String, dynamic>> data = await sqFliteDatabase.queryAll();
      final List<NotesModel> notes = data.map((item) => NotesModel.fromJson(item)).toList();
      emit(notes);
    } catch (error) {
      emit(state);
      debugPrint('Error fetching notes: $error');
    }
    });

    on<AddNotesEvent>((event, emit) async {
     try {
       final int noteId = await sqFliteDatabase.insert(event.notes.toJson());
       final NotesModel updatedNote = event.notes;
       updatedNote.id = noteId;
       final List<NotesModel> updatedNotes = List.from(state)..add(updatedNote);
       emit(updatedNotes);
    } catch (error) {
      emit(state); 
      debugPrint('Error adding note: $error');
    }
   });

    on<DeleteNotesEvent>((event, emit) async {
       try {
         await sqFliteDatabase.delete(event.notes.id!);
         final List<NotesModel> updatedNotes =
             state.where((element) => element.id != event.notes.id).toList();
         emit(updatedNotes);
       } catch (error) {
         emit(state); // Emit current state if an error occurs
         debugPrint('Error deleting note: $error');
       }
     });


    on<UpdateNotesEvent>((event, emit) async {
     try {
   
      await sqFliteDatabase.update(
      id: event.notes.id!,
      content: event.notes.content!,
      title: event.notes.title!,
      );

  
      final updatedNotes = await sqFliteDatabase.queryAll().then((value) {
      List<NotesModel> notes = [];
      for (var item in value) {
       
        notes.add(NotesModel.fromJson(item));
      }
      return notes;
     });

   
      emit(updatedNotes);
      } catch (error) {
   
      emit(state); 
      debugPrint('Error updating notes: $error');
      }
      });
  }

  
}
