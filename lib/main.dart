import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app/models/reminder.dart';
import 'package:reminder_app/providers/reminder_provider.dart';
import 'package:reminder_app/screens/addreminder_screen.dart';
import 'package:reminder_app/screens/reminders_screen.dart';
import 'assets/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:reminder_app/controllers/notification_controller.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ReminderAdapter());
  await Hive.openBox<Reminder>('reminders');
  tz.initializeTimeZones();
  runApp(ReminderApp());
}

class ReminderApp extends StatefulWidget {
  @override
  _ReminderAppState createState() => _ReminderAppState();
}

class _ReminderAppState extends State<ReminderApp> {

  @override
  void initState() {
    super.initState();
    NotificationApi.init(initScheduled: true);
    listenNotifications();
  }

  void listenNotifications() =>
      NotificationApi.onNotifications.stream.listen((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ReminderPage()));
  });

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  int _currentIndex = 0;
  final List<Widget> tabs = [AddReminder(),ReminderPage()];
  final ThemeData theme = ThemeData();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ReminderProvider()),
      ],
      child: MaterialApp(
        theme: theme.copyWith(
          textTheme: GoogleFonts.notoSansTextTheme(),
          colorScheme: theme.colorScheme.copyWith(
              primary: kNeonRed,
              secondary: Colors.black,
          ),
        ),
        home: GestureDetector(
          onTap: (){
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
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
        ),
      ),
    );
  }
}
