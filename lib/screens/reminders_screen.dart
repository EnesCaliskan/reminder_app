import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReminderPage extends StatefulWidget {
  const ReminderPage({Key? key}) : super(key: key);

  @override
  _ReminderPageState createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('reminders screen'),
    );
  }
}
