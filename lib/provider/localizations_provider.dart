import 'package:flutter/cupertino.dart';

class LocalizationsProvider extends ChangeNotifier {
  Locale _locale = Locale('id');
  Locale get locale => _locale;

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }
}
