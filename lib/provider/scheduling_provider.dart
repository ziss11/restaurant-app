import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/helper/date_time_helper.dart';
import 'package:restaurant_app/data/service/background_service.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isScheduled = false;

  bool get isScheduled => _isScheduled;

  Future<bool> scheduledRestaurant(bool value) async {
    _isScheduled = value;

    if (_isScheduled) {
      print('Scheduling Restaurant Started');

      notifyListeners();

      return await AndroidAlarmManager.periodic(
        Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      print('Scheduling Restaurant Cancelled');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
