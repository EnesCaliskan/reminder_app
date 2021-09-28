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
          padding: EdgeInsets.only(top: 40.0, left: 35.0, right: 35.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              TimePicker(dateText: 'Start from', timeInfo: 'startingTime',),
              TimePicker(dateText: 'Until', timeInfo: 'finishingTime',),
            ],
          ),
        ),
        SaveButton(),
      ],
    );
  }
}
