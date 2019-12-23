import 'package:flutter/material.dart';
import 'package:flutter_sqllite/models/note.dart';
import 'package:flutter_sqllite/utils/database_helper.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class NoteDetail extends StatefulWidget {
  final String appBarTitle;
  final Note note;

  NoteDetail(this.note, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NoteDetailState(this.note, this.appBarTitle);
  }
}

class _NoteDetailState extends State<NoteDetail> {
  String appBarTitle;
  Note note;

  DatabaseHelper helper = DatabaseHelper();

  _NoteDetailState(this.note, this.appBarTitle);

  static var _priorities = ['Hight', 'Low'];
  var _defaultProperty = _priorities[0];
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    titleController.text = note.title;
    descriptionController.text = note.description;

    // TODO: implement build
    return WillPopScope(
        onWillPop: () {
          moveToLastScreen();
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text(this.appBarTitle),
              leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    moveToLastScreen();
                  }),
            ),
            body: Padding(
              padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
              child: ListView(
                children: <Widget>[
                  ListTile(
                    title: DropdownButton(
                        items: _priorities.map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Text(dropDownStringItem),
                          );
                        }).toList(),
                        style: textStyle,
                        value: getPriorityAsString(note.priority),
                        onChanged: (valueSelectedByUser) {
                          setState(() {
                            debugPrint('User selected $valueSelectedByUser');
                            updatePriorityAsInt(valueSelectedByUser);
                          });
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: TextField(
                      controller: titleController,
                      style: textStyle,
                      onChanged: (value) {
                        debugPrint('Something changed in Title Text Field');
                        updateTitle();
                      },
                      decoration: InputDecoration(
                          labelText: 'Title',
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: TextField(
                      controller: descriptionController,
                      style: textStyle,
                      onChanged: (value) {
                        debugPrint(
                            'Something changed in Description Text Field');
                        updateDescription();
                      },
                      decoration: InputDecoration(
                          labelText: 'Description',
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                              color: Theme.of(context).primaryColorDark,
                              textColor: Theme.of(context).primaryColorLight,
                              child: Text(
                                'Save',
                                textScaleFactor: 1.5,
                              ),
                              onPressed: () {
                                setState(() {
                                  debugPrint('Save button clicked');
                                  _save();
                                });
                              }),
                        ),
                        Container(
                          width: 5.0,
                        ),
                        Expanded(
                          child: RaisedButton(
                              color: Theme.of(context).primaryColorDark,
                              textColor: Theme.of(context).primaryColorLight,
                              child: Text(
                                'Delete',
                                textScaleFactor: 1.5,
                              ),
                              onPressed: () {
                                setState(() {
                                  debugPrint('Delete button clicked');
                                  _delete();
                                });
                              }),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )));
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  // Convert the String priority in the form of integer before saving it to Database
  void updatePriorityAsInt(String value) {
    switch (value) {
      case 'Hight':
        note.priority = 1;
        break;
      case 'Low':
        note.priority = 2;
        break;
    }
  }

  // Convert int priority to String priority and display to to user in DropDown
  String getPriorityAsString(int value) {
    String str;
    switch (value) {
      case 1:
        str = _priorities[0];
        break;
      case 2:
        note.priority = 2;
        str = _priorities[1];
        break;
    }
    return str;
  }

  // Update the title of object
  void updateTitle() {
    note.title = titleController.text;
  }

  // Update the description of Note object
  void updateDescription() {
    note.description = descriptionController.text;
  }

  // Save data to database
  void _save() async {
    moveToLastScreen();
    note.date = DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());
    int result;
    if (note.id != null) {
      // Case 1: Update Operation
      result = await helper.updateNote(note);
    } else {
      // Case 2: Insert Operation
      result = await helper.insertNote(note);
    }

    if (result != 0) // Success
      _showAlterDialog('Status', 'Note Saved Successfully');
    else // Failure
      _showAlterDialog('Status', 'Problem Saving Note !');
  }

  // Delete data from database
  void _delete() async {
    /** - Case 1: If user is trying to delete the NEW NOTE i.e.
     *  he has to come to the detail page by pressing the FAB
     *  of NoteList page.
     *
     *  - Case 2: User is trying to delete the old note that has
     *  a valid ID.
     *
     */

    moveToLastScreen();
    // Case 1.
    if (note.id == null) {
      _showAlterDialog('Status', 'No Note was deleted');
      return;
    }

    // Case 2.
    int result = await helper.deleteNote(note.id);
    if (result != 0) {
      _showAlterDialog('Status', 'Note Deleted Successfully');
    } else {
      _showAlterDialog('Status', 'Error Occured while Deleting');
    }
  }

  void _showAlterDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
