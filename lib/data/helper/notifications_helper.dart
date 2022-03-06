import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/data/model/list_restaurant.dart';
import 'package:rxdart/rxdart.dart';

final selectNotificationSubject = BehaviorSubject<String>();

final random = Random().nextInt(20);

class NotificationsHelper {
  static NotificationsHelper? _notificationsHelper;

  NotificationsHelper._internal() {
    _notificationsHelper = this;
  }

  factory NotificationsHelper() =>
      _notificationsHelper ?? NotificationsHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    var initializationSetting = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSetting,
      onSelectNotification: (String? payload) async {
        if (payload == null) {
          print('notification payload: $payload');
        }
        selectNotificationSubject.add(payload ?? 'payload kosong');
      },
    );
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      ListRestaurant restaurant) async {
    var _channelId = '1';
    var _channelName = 'channel_01';
    var _channelDesc = 'Restaurant App';

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDesc,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      styleInformation: DefaultStyleInformation(true, true),
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    var titleNotifications = '<b> Restaurant has been Open </b>';
    var titleRestaurant = restaurant.restaurants[random].name;

    await flutterLocalNotificationsPlugin.show(
      0,
      titleNotifications,
      titleRestaurant,
      platformChannelSpecifics,
      payload: jsonEncode(
        {'number': random, 'data': restaurant.toJson()},
      ),
    );
  }

  void configureSelectedNotificationSubject(
      String route, BuildContext context) async {
    selectNotificationSubject.stream.listen(
      (String payload) {
        var data = ListRestaurant.fromJson(json.decode(payload)['data']);
        var restaurant = data.restaurants[json.decode(payload)['number']].id;
        Navigator.pushNamed(context, route, arguments: restaurant);
      },
    );
  }
}
