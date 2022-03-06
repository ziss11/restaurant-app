import 'dart:convert';

import 'package:restaurant_app/data/model/detail_restaurant.dart';
import 'package:restaurant_app/data/model/list_restaurant.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/search_restaurant.dart';

class ApiService {
  Future<ListRestaurant> getListRestaurant() async {
    final apiURL = 'https://restaurant-api.dicoding.dev/list';
    final response = await http.get(Uri.parse(apiURL));
    final jsonObject = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return ListRestaurant.fromJson(jsonObject);
    } else {
      throw Exception('Gagal mendapatkan data');
    }
  }

  Future<DetailRestaurant> getDetailRestaurant(String id) async {
    final apiURL = 'https://restaurant-api.dicoding.dev/detail/' + id;
    final response = await http.get(Uri.parse(apiURL));
    final jsonObject = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return DetailRestaurant.fromJson(jsonObject);
    } else {
      throw Exception('Gagal mendapatkan data');
    }
  }

  Future<Review> addReview(String id, String name, String review) async {
    final apiURL = 'https://restaurant-api.dicoding.dev/review';
    final response =
        await http.post(Uri.parse(apiURL), headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
      'X-Auth-Token': '12345',
    }, body: {
      "id": id,
      "name": name,
      "review": review,
    });

    final jsonObject = jsonDecode(response.body);

    if (response.statusCode == 200) {
      print(response.statusCode);
      return Review.fromJson(jsonObject);
    } else {
      print(response.statusCode);
      throw Exception('Data tidak berhasil di tambahkan!');
    }
  }

  Future<SearchRestaurant> searchRestaurant(String query) async {
    final apiURL = 'https://restaurant-api.dicoding.dev/search?q=' + query;
    final response = await http.get(Uri.parse(apiURL));
    final jsonObject = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return SearchRestaurant.fromJson(jsonObject);
    } else {
      throw Exception('Gagal mendapatkan data');
    }
  }
}
