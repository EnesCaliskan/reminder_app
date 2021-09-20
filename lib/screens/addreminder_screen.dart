// ignore_for_file: prefer_const_constructors
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reminder_app/widgets/addreminder_widgets.dart';

class AddReminder extends StatefulWidget {
  const AddReminder({Key? key}) : super(key: key);

  @override
  _AddReminderState createState() => _AddReminderState();
}

class _AddReminderState extends State<AddReminder> {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ReminderTitle(),
        CreateTextField(),
        Padding(
          padding: EdgeInsets.all(40.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AddDateColumn(dateText: 'Starts from', date: 'placeholder'),
              AddDateColumn(dateText: 'Until', date: 'placeholder'),
            ],
          ),
        ),
        Container(
          decoration: buttonStyle,
          child: TextButton(
            onPressed: (){},
            child: Text('Save', style: TextStyle(fontSize: 16.0,color: Colors.black),),
          ),
        ),
      ],
    );
  }
}