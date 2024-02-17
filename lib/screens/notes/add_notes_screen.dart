
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_assignment/bloc/notes/notes_bloc.dart';
import 'package:notes_assignment/constants/constants.dart';
import 'package:notes_assignment/models/notes_model.dart';
import 'package:notes_assignment/widgets/submit_button.dart';
import 'package:notes_assignment/widgets/widget_components.dart';

class AddNotesScreen extends StatefulWidget {
   const AddNotesScreen({super.key});
  static const route = "/AddNotesScreen";

  @override
  State<AddNotesScreen> createState() => _AddNotesScreenState();
}

class _AddNotesScreenState extends State<AddNotesScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final _form = GlobalKey<FormState>();
  NotesModel? initalNote;
  bool isEditable = false;

  
  getInitData(){
  final args = ModalRoute.of(context)?.settings.arguments;

  if(args != null){

   NotesModel note = (args as Map)['note'];
  
   setState(() {
     _titleController.text = note.title ?? '';
     _contentController.text = note.content ??'';
     initalNote = note;
     isEditable = true;
   });
  }
 
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
    getInitData();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {  
  NotesBloc notesBloc = BlocProvider.of<NotesBloc>(context,listen: true);
  
  return Scaffold(
      appBar: myAppBar(context: context, title: isEditable ?'' :"Add Note"),
      body: Form(
        key: _form,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Padding(
                padding: const  EdgeInsets.symmetric(horizontal: 15,vertical: 2),
                child: TextFormField(
                  maxLines: null,
                  controller: _titleController,
                  cursorColor: myPrimaryColor,
                  style: const  TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(
                    hintText: 'Title',
                    hintStyle: TextStyle(fontSize: 29),
                    
                    border: InputBorder.none
                    
                  ),
                  validator: (value) {
                  if(value!.trim().isEmpty){
                    return "Please enter title of your note";
                  }else{
                    return null;
                  }
                },
                ),
              ),
               const Divider(),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: _contentController,
                  maxLines: null,
                  cursorColor: myPrimaryColor,
                 
                  decoration: const InputDecoration(
                    hintText: 'Start typing...',    
                    border: InputBorder.none
                  ),
                  
                ),
              ),      
            ],),
          ),
      ),
      bottomNavigationBar: SubmitButton(onTap: (){
       if(_form.currentState!.validate()){
       if(isEditable){
        
       notesBloc.add(UpdateNotesEvent(NotesModel(title: _titleController.text,content: _contentController.text,id: initalNote!.id)));
       }else{
       notesBloc.add(AddNotesEvent(NotesModel(title: _titleController.text,content: _contentController.text)));
       }
       Navigator.pop(context);
       }
      }, lable: isEditable ? "Save changes" : "Add Notes",isAtBottom: true,),
    );

  }
}