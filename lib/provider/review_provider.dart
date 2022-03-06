import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/service/api_service.dart';
import 'package:restaurant_app/data/model/detail_restaurant.dart';

enum ReviewState { Loading, NoHasData, HasData, HasError }

class ReviewProvider extends ChangeNotifier {
  final ApiService apiService;

  Review? _customerReview;
  String? _message;
  ReviewState? _state;

  ReviewProvider({
    required this.apiService,
  });

  Review get customerReview => _customerReview!;
  String get message => _message!;
  ReviewState get state => _state!;

  Future<dynamic> addReview(String id, String name, String review) async {
    try {
      _state = ReviewState.Loading;
      notifyListeners();

      final customerReview = await apiService.addReview(id, name, review);

      if (customerReview.customerReviews.isEmpty) {
        _state = ReviewState.NoHasData;
        notifyListeners();

        return _message = 'Belum ada review untuk restaurant ini.';
      } else {
        _state = ReviewState.HasData;
        notifyListeners();

        return _customerReview = customerReview;
      }
    } catch (e) {
      _state = ReviewState.HasError;
      notifyListeners();

      return _message = e.toString();
    }
  }
}
