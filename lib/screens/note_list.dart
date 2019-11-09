import 'package:flutter/material.dart';
import './note_detail.dart';

class NoteList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NoteListState();
  }
}

class _NoteListState extends State<NoteList> {
  int count = 2;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: _getNoteListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('FloatingActionButton is pressed');
          navigateToDetail('Add new item');
        },
        tooltip: 'Add Note',
        child: Icon(Icons.add),
      ),
        
    );
  }

  ListView _getNoteListView() {
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;

    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.yellow,
                child: Icon(Icons.keyboard_arrow_right),
              ),
              title: Text(
                'Dummy date',
                style: titleStyle,
              ),
              trailing: Icon(
                Icons.delete,
                color: Colors.grey,
              ),
              onTap: () {
                debugPrint('ListTile Tapped');
                navigateToDetail('Edit item');
              },
            ),
          );
        });
  }
}
