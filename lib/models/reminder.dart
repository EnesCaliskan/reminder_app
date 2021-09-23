import 'package:hive/hive.dart';
part 'reminder.g.dart';

@HiveType(typeId: 0)
class Reminder extends HiveObject{
  @HiveField(0)
  late String reminderText;

  @HiveField(1)
  late String startingTime;

  @HiveField(2)
  late String finishingTime;
}