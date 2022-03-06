import 'dart:isolate';

import 'dart:ui';

import 'package:restaurant_app/data/helper/notifications_helper.dart';
import 'package:restaurant_app/data/service/api_service.dart';
import 'package:restaurant_app/main.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _service;
  static String _isolateName = 'isolate';
  static SendPort? _sendPort;

  BackgroundService._createObject();

  factory BackgroundService() {
    if (_service == null) {
      _service = BackgroundService._createObject();
    }
    return _service!;
  }

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    print('Alarm fired');

    final NotificationsHelper _notificatonHelper = NotificationsHelper();
    var result = await ApiService().getListRestaurant();
    await _notificatonHelper.showNotification(
        flutterLocalNotificationsPlugin, result);

    _sendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _sendPort?.send(null);
  }

  Future<void> someTask() async {
    print('Execute some process');
  }
}
