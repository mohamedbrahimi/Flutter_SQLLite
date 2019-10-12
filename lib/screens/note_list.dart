import 'package:flutter/material.dart';

class NoteList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NoteListState();
  }

}

class _NoteListState extends State<NoteList> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: _getNoteListView(),
    );
  }

  ListView _getNoteListView(){
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;

    return ListView.builder(itemBuilder: null);
  }

}