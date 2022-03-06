import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/widgets/restaurant_tile.dart';
import 'package:restaurant_app/widgets/skeleton_container.dart';

import '../utilities/style.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, favorite, _) {
        if (favorite.state == DbState.Loading) {
          return SkeletonContainer();
        } else {
          if (favorite.state == DbState.HasData) {
            return ListView.builder(
              key: Key('mylist'),
              padding: EdgeInsets.symmetric(
                horizontal: defaultMargin,
                vertical: defaultMargin,
              ),
              physics: BouncingScrollPhysics(),
              itemCount: favorite.favRestaurant.length,
              itemBuilder: (context, index) {
                var favRes = favorite.favRestaurant[index];
                return RestaurantTile(
                  id: favRes.id,
                  pictureId: favRes.pictureId,
                  name: favRes.name,
                  city: favRes.city,
                  rating: favRes.rating,
                );
              },
            );
          } else if (favorite.state == DbState.NoHasData) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Center(
                child: Text(
                  favorite.message,
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
                    favorite.message,
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
}
