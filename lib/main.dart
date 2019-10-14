import 'package:flutter/material.dart';
import 'screens/note_list.dart';
import 'screens/note_detail.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NoteKeeper',
      home: NoteDetail(),
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
       //   brightness: Brightness.dark,
       //   primaryColor: Colors.indigo,
       //   accentColor: Colors.indigoAccent
      ),
    );
  }
}