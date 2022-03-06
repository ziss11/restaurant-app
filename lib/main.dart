import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/data/helper/notifications_helper.dart';
import 'package:restaurant_app/data/helper/preference_helper.dart';
import 'package:restaurant_app/data/service/api_service.dart';
import 'package:restaurant_app/data/helper/database_helper.dart';
import 'package:restaurant_app/data/model/detail_restaurant.dart';
import 'package:restaurant_app/data/service/background_service.dart';
import 'package:restaurant_app/pages/detail_page.dart';
import 'package:restaurant_app/pages/main_page.dart';
import 'package:restaurant_app/pages/review_page.dart';
import 'package:restaurant_app/pages/splash_screen.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/provider/page_provider.dart';
import 'package:restaurant_app/provider/preference_provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/provider/review_provider.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationsHelper _notifiactionHelper = NotificationsHelper();
  final BackgroundService _backgroundService = BackgroundService();

  _backgroundService.initializeIsolate();

  await AndroidAlarmManager.initialize();
  await _notifiactionHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PageProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => RestaurantProvider(
            apiService: ApiService(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(
            databaseHelper: DatabaseHelper(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => SchedulingProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PreferenceProvider(
            preferenceHelper: PreferenceHelper(
              sharedPreference: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider<ReviewProvider>(
          create: (_) => ReviewProvider(
            apiService: ApiService(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                primaryColor,
              ),
            ),
          ),
          scaffoldBackgroundColor: whiteColor,
          appBarTheme: AppBarTheme(
            elevation: 0,
            backgroundColor: whiteColor,
          ),
        ),
        navigatorKey: navigatorKey,
        initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName: (context) => SplashScreen(),
          MainPage.routeName: (context) => MainPage(),
          DetailPage.routeName: (context) => DetailPage(
                id: ModalRoute.of(context)?.settings.arguments as String,
              ),
          ReviewPage.routeName: (context) => ReviewPage(
                review: ModalRoute.of(context)?.settings.arguments as Review,
              ),
        },
      ),
    );
  }
}
