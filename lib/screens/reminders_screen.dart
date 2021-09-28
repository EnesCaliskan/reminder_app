import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:reminder_app/assets/constants.dart';
import 'package:reminder_app/models/reminder.dart';
import 'package:reminder_app/providers/boxes.dart';
import 'package:reminder_app/widgets/addreminder_widgets.dart';
import 'package:reminder_app/controllers/notification_controller.dart';

class ReminderPage extends StatefulWidget {
  const ReminderPage({Key? key}) : super(key: key);

  @override
  _ReminderPageState createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Future clearReminders() async {
      final box = Boxes.getReminders();
      box.deleteAll(box.keys);
      NotificationApi.turnOffNotification();
    }

    Future clearSelected(Reminder reminder) async {
      reminder.delete();
    }

    Widget buildContent(List<Reminder> reminders){
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(top: 70.0, left: 25.0),
            child: Container(
              child: Text(
                'Reminders',
                style: TextStyle(
                    fontSize: 24.0,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: reminders.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Container(
                      decoration: buttonStyle,
                      height: 100.0,
                      width: 100.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                 SizedBox(
                                   width: 250.0,
                                   child: Text(
                                      reminders[index].reminderText,
                                      style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                    ),
                                     overflow: TextOverflow.ellipsis,
                                     softWrap: false,
                                ),
                                 ),
                                Text(
                                  reminders[index].startingTime,
                                    style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: kNeonRed,
                                  ),
                                ),
                                Text(
                                  reminders[index].finishingTime,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: kNeonRed,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: (){
                              setState(() {
                                clearSelected(reminders[index]);
                              });
                            },
                            icon: Icon(Icons.delete, color: kNeonRed,),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: SizedBox(
              height: 50.0,
              width: 160.0,
              child: DecoratedBox(
                decoration: buttonStyle,
                child: TextButton(
                  onPressed: () {
                    clearReminders();
                  },
                  child: const Text(
                    'Clear Reminders',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Scaffold(
        body: ValueListenableBuilder<Box<Reminder>>(
            valueListenable: Boxes.getReminders().listenable(),
            builder: (context, box, _) {
              final reminders = box.values.toSet().toList().cast<Reminder>();
              return buildContent(reminders);
            }));

  }
}


