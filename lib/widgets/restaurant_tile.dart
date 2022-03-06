import 'package:flutter/material.dart';
import '../utilities/navigation.dart';
import 'package:restaurant_app/pages/detail_page.dart';
import '../utilities/style.dart';

class RestaurantTile extends StatelessWidget {
  final String id;
  final String pictureId;
  final String name;
  final String city;
  final double rating;

  RestaurantTile({
    required this.id,
    required this.pictureId,
    required this.name,
    required this.city,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigation.intentWithData(DetailPage.routeName, id);
      },
      child: Card(
        color: lightGreyColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            defaultRadius,
          ),
        ),
        margin: EdgeInsets.only(
          bottom: 16,
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Hero(
                tag: pictureId,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    'https://restaurant-api.dicoding.dev/images/small/' +
                        pictureId,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: 18,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      overflow: TextOverflow.ellipsis,
                      style: blackText.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: greyColor,
                          size: 15,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          city,
                          style: greyText.copyWith(
                            fontWeight: medium,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star_rounded,
                          color: primaryColor,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          rating.toString(),
                          style: blackText.copyWith(
                            fontWeight: semiBold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
