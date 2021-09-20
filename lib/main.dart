import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reminder_app/screens/addreminder_screen.dart';
import 'package:reminder_app/screens/reminders_screen.dart';
import 'assets/constants.dart';

void main() async {
  runApp(ReminderApp());
}

class ReminderApp extends StatefulWidget {
  @override
  _ReminderAppState createState() => _ReminderAppState();
}

class _ReminderAppState extends State<ReminderApp> {
  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  int _currentIndex = 0;
  final List<Widget> tabs = [AddReminder(),ReminderPage()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Helvetica',
      ),
      home: Scaffold(
        body: tabs[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: kNeonRed,
          unselectedItemColor: Colors.black,
          onTap: onTappedBar,
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.note_add), label: 'Add a reminder'),
            BottomNavigationBarItem(
                icon: Icon(Icons.speaker_notes), label: 'See reminders'),
          ],
        ),
      ),
    );
  }
}
