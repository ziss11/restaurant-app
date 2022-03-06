import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/model/list_restaurant.dart';

void main() {
  test('Parse berhasil', () async {
    var restaurant = {
      "id": "rqdv5juczeskfw1e867",
      "name": "Melting Pot",
      "description":
          "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
      "pictureId": "14",
      "city": "Medan",
      "rating": 4.2,
    };
    var parseRes = ListRestaurantItem.fromJson(restaurant);

    expect(parseRes, true);
  });
}
