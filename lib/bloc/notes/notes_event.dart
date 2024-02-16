part of 'notes_bloc.dart';

abstract class NotesEvents{}

class FetchNotesEvent extends NotesEvents{
  
  FetchNotesEvent();
}

class AddNotesEvent extends NotesEvents{
  NotesModel notes;
  AddNotesEvent(this.notes);

}

class DeleteNotesEvent extends NotesEvents{
  NotesModel notes;
  DeleteNotesEvent(this.notes);
}

class UpdateNotesEvent extends NotesEvents{
  NotesModel notes;
  UpdateNotesEvent(this.notes);
}