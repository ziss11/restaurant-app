import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/service/api_service.dart';
import 'package:restaurant_app/data/model/detail_restaurant.dart';

enum DetailState { Loading, NoHasData, HasData, HasError }

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  DetailRestaurant? _detailRestaurant;
  String? _message;
  DetailState? _state;

  DetailRestaurantProvider({required this.apiService, required this.id}) {
    _getDetailRestaurant(id);
  }

  DetailRestaurant get detailRestaurant => _detailRestaurant!;
  String get message => _message!;
  DetailState get state => _state!;

  Future<dynamic> _getDetailRestaurant(String id) async {
    try {
      _state = DetailState.Loading;
      notifyListeners();

      final detailRestaurant = await apiService.getDetailRestaurant(id);
      if (detailRestaurant.error) {
        _state = DetailState.NoHasData;
        notifyListeners();
      } else {
        _state = DetailState.HasData;
        notifyListeners();

        return _detailRestaurant = detailRestaurant;
      }
    } catch (e) {
      _state = DetailState.HasError;
      notifyListeners();

      return _message = e.toString();
    }
  }
}
