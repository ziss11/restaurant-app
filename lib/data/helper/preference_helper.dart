import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {
  final Future<SharedPreferences> sharedPreference;

  PreferenceHelper({required this.sharedPreference});

  static const dailyRestaurant = 'Daily Restaurant';

  Future<bool> get isRestaurantDaily async {
    final prefs = await sharedPreference;

    return prefs.getBool(dailyRestaurant) ?? false;
  }

  void setDailyRestaurant(bool value) async {
    final prefs = await sharedPreference;
    prefs.setBool(dailyRestaurant, value);
  }
}
