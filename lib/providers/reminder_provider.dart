import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReminderProvider with ChangeNotifier{
  late String _reminderMessage;
  late String _startTime;
  late String _finishingTime;

  ReminderProvider(){
    _reminderMessage = '';
    _startTime = '';
    _finishingTime = '';
  }

//getters
  String get reminderMessage => _reminderMessage;
  String get startTime => _startTime;
  String get finishingTime => _finishingTime;

//setters
  void setReminderMessage(String reminderMessage){
    _reminderMessage = reminderMessage;
    notifyListeners();

  }

  void setStartingTime(String startTime){
    _startTime = startTime;
    notifyListeners();
  }

  void setFinishingTime(String finishingTime){
    _finishingTime = finishingTime;
    notifyListeners();
  }

}



