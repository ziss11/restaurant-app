import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/helper/preference_helper.dart';

class PreferenceProvider extends ChangeNotifier {
  final PreferenceHelper preferenceHelper;

  PreferenceProvider({required this.preferenceHelper}) {
    _getDailyRestaurant();
  }

  bool _isDailyRestaurant = false;
  bool get isDailyResturant => _isDailyRestaurant;

  void _getDailyRestaurant() async {
    _isDailyRestaurant = await preferenceHelper.isRestaurantDaily;
    notifyListeners();
  }

  void enableDailyRestaurant(bool value) {
    preferenceHelper.setDailyRestaurant(value);
    _getDailyRestaurant();
  }
}
