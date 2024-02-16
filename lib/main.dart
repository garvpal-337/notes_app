import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_assignment/bloc/notes/notes_bloc.dart';
import 'package:notes_assignment/bloc/weather/weather_bloc.dart';
import 'package:notes_assignment/routes/app_routes.dart';
import 'package:notes_assignment/screens/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NotesBloc(),),
        BlocProvider(create: (context) => WeatherBloc(),)

      ],
      child: MaterialApp(
        routes: AppRoutes.getAll(),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
