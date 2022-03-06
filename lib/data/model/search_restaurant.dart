import 'dart:convert';

import 'package:restaurant_app/data/model/list_restaurant.dart';

SearchRestaurant searchFromJson(String str) =>
    SearchRestaurant.fromJson(json.decode(str));

String searchToJson(SearchRestaurant data) => json.encode(data.toJson());

class SearchRestaurant {
  SearchRestaurant({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  final bool error;
  final int founded;
  final List<ListRestaurantItem> restaurants;

  factory SearchRestaurant.fromJson(Map<String, dynamic> json) =>
      SearchRestaurant(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<ListRestaurantItem>.from(
            json["restaurants"].map((x) => ListRestaurantItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "founded": founded,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}
