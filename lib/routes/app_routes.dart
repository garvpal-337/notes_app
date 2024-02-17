
import 'package:flutter/material.dart';
import 'package:notes_assignment/screens/home/home_screen.dart';
import 'package:notes_assignment/screens/notes/add_notes_screen.dart';

class AppRoutes {
  static Map<String,WidgetBuilder> getAll() => _routes;
  static final  Map<String,WidgetBuilder> _routes = {
     HomeScreen.route:(ctx)=>  const  HomeScreen(),
     AddNotesScreen.route: (ctx) => const  AddNotesScreen(),
  };
}