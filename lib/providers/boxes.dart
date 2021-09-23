import 'package:hive/hive.dart';
import 'package:reminder_app/models/reminder.dart';

class Boxes{
  static Box<Reminder> getReminders() =>
      Hive.box<Reminder>('reminders');
}