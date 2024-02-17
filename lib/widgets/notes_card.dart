
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_assignment/bloc/notes/notes_bloc.dart';
import 'package:notes_assignment/constants/constants.dart';
import 'package:notes_assignment/models/notes_model.dart';
import 'package:notes_assignment/screens/notes/add_notes_screen.dart';
import 'package:notes_assignment/widgets/widget_components.dart';

class NotesCard extends StatelessWidget {
  const NotesCard({
    super.key,
    required this.item,
  });

  final NotesModel item;

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, AddNotesScreen.route,arguments: {'note':item});
      },
      child: Container(
       margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
        padding: const  EdgeInsets.all(15),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
        color: myPrimaryColor.withOpacity(0.2)
        ),
        child: Row(children: [
          myIconButton(icon:  const Icon(CupertinoIcons.pencil_ellipsis_rectangle,color: myWhite,size: 29,),color: myPrimaryColor,radius: 10),
         const  SizedBox(width: 10,),
           Expanded(child: Text(item.title ?? '',
           maxLines: 1,
           overflow: TextOverflow.ellipsis,
           style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
           ),
           myIconButton(
            onTap: (){
            showMyDialoge(context: context, content: const  Text('Do You really want to delete this note ?',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
            onYes: (){
              final notesBloc = BlocProvider.of<NotesBloc>(context,listen: false);
              notesBloc.add(DeleteNotesEvent(item));
              Navigator.pop(context);
            });
            },
            icon: const Icon(CupertinoIcons.delete_solid,color: myPrimaryColor,size: 23,)),
        ],),
      ),
    );
  }
}
