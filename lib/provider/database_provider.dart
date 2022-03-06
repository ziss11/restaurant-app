import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/helper/database_helper.dart';
import 'package:restaurant_app/data/model/list_restaurant.dart';

enum DbState { Loading, HasData, NoHasData, HasError }

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getFavorite();
  }

  late DbState _state;
  DbState get state => _state;

  String? _message;
  String get message => _message!;

  List<ListRestaurantItem>? _favRestaurant = [];
  List<ListRestaurantItem> get favRestaurant => _favRestaurant!;

  Future<dynamic> _getFavorite() async {
    try {
      _state = DbState.Loading;
      notifyListeners();

      _favRestaurant = await databaseHelper.getFavorite();

      if (_favRestaurant!.isEmpty) {
        _state = DbState.NoHasData;
        notifyListeners();

        return _message = 'Anda belum menambahkan favorite!';
      } else {
        _state = DbState.HasData;
        notifyListeners();

        return _favRestaurant = favRestaurant;
      }
    } catch (e) {
      _state = DbState.HasError;
      notifyListeners();

      return _message = 'Anda belum menambahkan favorite!';
    }
  }

  void addFavorite(ListRestaurantItem restaurant) async {
    try {
      await databaseHelper.addFavorite(restaurant);
      _getFavorite();
    } catch (e) {
      _state = DbState.HasError;
      _message = 'Tidak ada koneksi internet';
      print(e.toString());
      notifyListeners();
    }
  }

  Future<bool> isFavorited(String id) async {
    final favoritResturant = await databaseHelper.getFavoriteById(id);
    return favoritResturant.isNotEmpty;
  }

  void deleteFavorite(String id) async {
    try {
      await databaseHelper.deleteFavorite(id);
      _getFavorite();
    } catch (e) {
      _state = DbState.HasError;
      _message = 'Tidak ada koneksi internet';
      notifyListeners();
    }
  }
}
