import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app/assets/constants.dart';
import 'package:reminder_app/controllers/notification_controller.dart';
import 'package:reminder_app/models/reminder.dart';
import 'package:reminder_app/providers/boxes.dart';
import 'package:reminder_app/providers/reminder_provider.dart';
import 'package:intl/intl.dart';

class AddDateColumn extends StatefulWidget {
  final String dateText;
  final String date;
  const AddDateColumn({Key? key, required this.dateText, required this.date})
      : super(key: key);

  @override
  _AddDateColumnState createState() => _AddDateColumnState();
}
class _AddDateColumnState extends State<AddDateColumn> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: buttonStyle,
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.date_range),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    widget.dateText,
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Text(
            widget.date,
            style: const TextStyle(
              fontSize: 16.0,
            ),
          ),
        ),
      ],
    );
  }
}

class CreateTextField extends StatefulWidget {
  const CreateTextField({Key? key}) : super(key: key);
  @override
  _CreateTextFieldState createState() => _CreateTextFieldState();
}
class _CreateTextFieldState extends State<CreateTextField> {
  final reminderTextController = TextEditingController();
  FocusNode _focusNode = new FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    reminderTextController.dispose();
    super.dispose();
    _focusNode.removeListener(_onFocusChange);
  }

  void _onFocusChange(){
    debugPrint("Focus:" +_focusNode.hasFocus.toString());
  }

  @override
  Widget build(BuildContext context) {
    var reminderProvider = Provider.of<ReminderProvider>(context);
    return Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0),
      child: Container(
        height: MediaQuery.of(context).size.width * 0.8,
        padding: EdgeInsets.all(10.0),
        decoration: buttonStyle,
        child: TextField(
          onChanged: (text){
            reminderProvider.setReminderMessage(text);
          },
          focusNode: _focusNode,
          controller: reminderTextController,
          textInputAction: TextInputAction.done,
          cursorColor: kNeonRed,
          style: TextStyle(
            fontSize: 25.0,
          ),
          decoration: InputDecoration.collapsed(
              hintText: 'Enter your reminder',
          ),
          maxLines: 20,
          maxLength: 70,
        ),
      ),
    );

  }
}

class ReminderTitle extends StatelessWidget {
  const ReminderTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(top: 70.0, bottom: 20.0, left: 25.0),
        child: Text(
          'Let\'s add a reminder',
          style: TextStyle(
            fontSize: 24.0,
          ),
        ),
      ),
    );
  }
}

Decoration buttonStyle = BoxDecoration(
  color: Colors.white,
  border: Border.all(color: Colors.black, width: 2),
  boxShadow: const [
    BoxShadow(
      color: Colors.black,
      offset: Offset(10.0, 10.0),
    )
  ],
);

class TimePicker extends StatefulWidget {
  final String dateText;
  final String timeInfo;
  const TimePicker({Key? key, required this.dateText, required this.timeInfo}) : super(key: key);

  @override
  _TimePickerState createState() => _TimePickerState();
}
class _TimePickerState extends State<TimePicker> {

  late TimeOfDay time;
  late TimeOfDay picked;
  late String formattedTime = "";

  @override
  void initState() {
    super.initState();
    time = TimeOfDay.now();
  }

  Future<void> selectTime (BuildContext context) async {
    var reminderProvider = Provider.of<ReminderProvider>(context, listen: false);
    picked = (await showTimePicker(
        context: context,
        initialTime: time,
    ))!;
    if(picked != null){
      setState(() {
        time = picked;
      });
      formattedTime = time.format(context);
      if(widget.timeInfo == 'startingTime'){
        reminderProvider.setStartingTime(formattedTime);
      }
      else{
        reminderProvider.setFinishingTime(formattedTime);
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: buttonStyle,
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      selectTime(context);
                    });
                  },
                  icon: const Icon(Icons.date_range),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    widget.dateText,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Text(
            formattedTime,
            style: TextStyle(
              fontSize: 18.0,
              color: kNeonRed,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class SaveButton extends StatefulWidget {
  const SaveButton({Key? key}) : super(key: key);

  @override
  _SaveButtonState createState() => _SaveButtonState();
}
class _SaveButtonState extends State<SaveButton> {
  DateTime now = DateTime.now();

  Future addReminder(String reminderText, String startingTime, String finishingTime) async {
    final reminder = Reminder()
      ..reminderText = reminderText
      ..startingTime = startingTime
      ..finishingTime = finishingTime;
    final box = Boxes.getReminders();
    box.add(reminder);
  }

  @override
  Widget build(BuildContext context) {
    var reminderProvider = Provider.of<ReminderProvider>(context);
    List list = List.generate(100, (i) => i);
    list.shuffle();
    int firstRandomNum = list[0];
    int secondRandomNum = list[1];
    return Container(
      decoration: buttonStyle,
      child: TextButton(
        onPressed: () {
          list.shuffle();
          addReminder(
              reminderProvider.reminderMessage,
              reminderProvider.startTime,
              reminderProvider.finishingTime);

          DateTime scheduledStartingDate = DateFormat(
            "yyyy-MM-dd hh:mm:ss"
          ).parse(
              "${now.year}-${now.month}-${now.day} ${reminderProvider.startTime}:00");

          DateTime scheduledFinishingDate = DateFormat(
              "yyyy-MM-dd hh:mm:ss"
          ).parse(
              "${now.year}-${now.month}-${now.day} ${reminderProvider.finishingTime}:00");


          NotificationApi.showScheduledNotification(
              id: firstRandomNum,
              title: 'Reminder!',
              body: reminderProvider.reminderMessage,
              payload: reminderProvider.reminderMessage,
              scheduledDate: scheduledStartingDate,
          );

          NotificationApi.showScheduledNotification(
            id: secondRandomNum,
            title: 'Time is up!',
            body: reminderProvider.reminderMessage,
            payload: reminderProvider.reminderMessage,
            scheduledDate: scheduledFinishingDate,
          );

          final snackBar = SnackBar(
            content: Text(
              'Reminder set up for ' + reminderProvider.startTime,
               style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            backgroundColor: Colors.black,
          );
          ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(snackBar);
        },
        child: const Text(
          'Save',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
