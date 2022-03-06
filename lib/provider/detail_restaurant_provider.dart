import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/service/api_service.dart';
import 'package:restaurant_app/data/model/detail_restaurant.dart';

enum DetailState { Loading, NoHasData, HasData, HasError }

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  DetailRestaurant? _detailRestaurant;
  Review? _review;
  String? _message;
  DetailState? _state;

  DetailRestaurantProvider({required this.apiService, required this.id}) {
    _getDetailRestaurant(id);
  }

  DetailRestaurant get detailRestaurant => _detailRestaurant!;
  Review get review => _review!;
  String get message => _message!;
  DetailState get state => _state!;

  set review(Review review) {
    _review = review;
    notifyListeners();
  }

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

        _review = Review(
          error: false,
          message: 'Success',
          customerReviews: detailRestaurant.restaurant.customerReviews,
        );
        return _detailRestaurant = detailRestaurant;
      }
    } catch (e) {
      _state = DetailState.HasError;
      notifyListeners();

      return _message = e.toString();
    }
  }
}
