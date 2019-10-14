import 'package:flutter/material.dart';

class NoteDetail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NoteDetailState();
  }

}

class _NoteDetailState extends State<NoteDetail> {

  static var _priorities = ['Hight', 'Low'];
  var _defaultProperty = _priorities[0];
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = Theme.of(context).textTheme.title;

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Note'),
      ),
    );
  }

}