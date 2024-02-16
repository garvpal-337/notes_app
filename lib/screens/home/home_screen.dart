

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_assignment/bloc/notes/notes_bloc.dart';
import 'package:notes_assignment/database/sqf_lite.dart';
import 'package:notes_assignment/models/notes_model.dart';
import 'package:notes_assignment/screens/notes/add_notes_screen.dart';
import 'package:notes_assignment/screens/weather/weather_screen.dart';
import 'package:notes_assignment/widgets/notes_card.dart';
import 'package:notes_assignment/widgets/widget_components.dart';

class HomeScreen extends StatefulWidget {
   const HomeScreen({super.key});
  static const route = '/homescreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  

  void openForm(context){
    showModalBottomSheet(context: context,
    isScrollControlled: true,
     builder: (context) {
     return const WeatherScreen();
    },);
  }
  
  Future<void> initaliseDatabase() async {
   await  SQFliteDatabase.instance.initDataBase();
  }
  Future<void> getdata()async {
   debugPrint('calling get data on home ...'); 
   final notesBloc = BlocProvider.of<NotesBloc>(context,listen: false);
   notesBloc.add(FetchNotesEvent());
  }

  void initData() async {
   await initaliseDatabase();
   await getdata();
  }


  @override
  void initState() {
  initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {    

    return Scaffold(
      appBar: myAppBar(context: context, title: 'My Notes',leading: false,elevation: 1,trailing: myIconButton(
        onTap: (){
          openForm(context);
        },
        icon:  Icon(Icons.cloud,color: Colors.blue.shade400,))),
      body: BlocBuilder<NotesBloc,List<NotesModel>>(
        builder: (context,state) {    
          return ListView.builder(
              padding: const EdgeInsets.only(top: 15),
              itemCount: state.length,
              itemBuilder: (context, index) {
              var item = state[index];
              return NotesCard(item: item);
          },);}
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(onPressed: () async{
        Navigator.pushNamed(context, AddNotesScreen.route);
      },label:const  Text( 'Add Note'),icon:const  Icon(Icons.add),),
    );
  }
}
