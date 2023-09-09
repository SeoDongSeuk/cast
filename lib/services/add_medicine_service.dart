import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class AddMedicineService with ChangeNotifier {
  final _alarms = <String>{
    '08:00',
    '13:00',
    '15:00',
  };

  Set<String> get alarm => _alarms;

  void addNowAlarm() {
    final now = DateTime.now();
    final nowTime = DateFormat('HH:mm').format(now);
    _alarms.add(nowTime);
    notifyListeners();
  }

  void removeAlarm(String alarmTime) {
    _alarms.remove(alarmTime);
    notifyListeners();
  }
}
