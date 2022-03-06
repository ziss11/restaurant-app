import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/service/api_service.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/utilities/common.dart';
import 'package:restaurant_app/widgets/custom_textfield.dart';
import 'package:restaurant_app/widgets/restaurant_tile.dart';
import 'package:restaurant_app/widgets/skeleton_container.dart';

import '../utilities/style.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _search = TextEditingController();
  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    Widget body() {
      return Consumer<RestaurantProvider>(
        builder: (context, state, _) => Container(
          margin: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                hint: AppLocalizations.of(context)!.searchRestaurant,
                icon: Icon(
                  Icons.search_rounded,
                  color: greyColor,
                ),
                controller: _search,
                onChanged: (value) {
                  setState(() {
                    _searchText = value;
                  });
                  state.buildSearchRestaurant(_searchText);
                },
              ),
              Text(
                AppLocalizations.of(context)!.popularRestaurant,
                style: blackText.copyWith(
                  fontSize: 22,
                  fontWeight: semiBold,
                ),
              ),
              SizedBox(
                height: 18,
              ),
            ],
          ),
        ),
      );
    }

    Widget menuList() {
      restaurantList() {
        return Consumer<RestaurantProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.Loading) {
              return SkeletonContainer();
            } else {
              if (state.state == ResultState.HasData) {
                final restaurant = state.restaurant;
                return ListView.builder(
                  padding: EdgeInsets.only(
                    left: defaultMargin,
                    right: defaultMargin,
                    bottom: 100,
                  ),
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: restaurant.restaurants.length,
                  itemBuilder: (context, index) {
                    final restaurantElement = restaurant.restaurants[index];
                    return RestaurantTile(
                      id: restaurantElement.id,
                      pictureId: restaurantElement.pictureId,
                      name: restaurantElement.name,
                      city: restaurantElement.city,
                      rating: restaurantElement.rating,
                    );
                  },
                );
              } else if (state.state == ResultState.NoHasData) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Center(
                    child: Text(
                      state.message,
                      style: blackText.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                    ),
                  ),
                );
              } else {
                return Column(
                  children: [
                    Center(
                      child: Image.asset(
                        'images/no_connection_image.png',
                        width: 150,
                        height: 200,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: defaultMargin,
                      ),
                      child: Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: blackText.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                      ),
                    ),
                  ],
                );
              }
            }
          },
        );
      }

      restaurantSearchlist() {
        return Consumer<RestaurantProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.Loading) {
              return SkeletonContainer();
            } else {
              if (state.state == ResultState.HasData) {
                final searhRestaurant = state.searchRestaurant;
                return ListView.builder(
                  padding: EdgeInsets.only(
                    left: defaultMargin,
                    right: defaultMargin,
                    bottom: 100,
                  ),
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: searhRestaurant.restaurants.length,
                  itemBuilder: (context, index) {
                    final restaurantElement =
                        searhRestaurant.restaurants[index];
                    return RestaurantTile(
                      id: restaurantElement.id,
                      pictureId: restaurantElement.pictureId,
                      name: restaurantElement.name,
                      city: restaurantElement.city,
                      rating: restaurantElement.rating,
                    );
                  },
                );
              } else if (state.state == ResultState.NoHasData) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.search_off_rounded,
                          size: 200,
                        ),
                        Text(
                          AppLocalizations.of(context)!.notFoundSearchMessage,
                          style: blackText.copyWith(
                            fontSize: 16,
                            fontWeight: medium,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Column(
                  children: [
                    Center(
                      child: Image.asset(
                        'images/no_connection_image.png',
                        width: 150,
                        height: 200,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: defaultMargin,
                      ),
                      child: Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: blackText.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                      ),
                    ),
                  ],
                );
              }
            }
          },
        );
      }

      return _searchText.isNotEmpty ? restaurantSearchlist() : restaurantList();
    }

    return ChangeNotifierProvider(
      create: (_) => RestaurantProvider(
        apiService: ApiService(),
      ),
      child: SafeArea(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            body(),
            menuList(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _search.dispose();
  }
}
