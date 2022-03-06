import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/data/model/list_restaurant.dart';
import 'package:restaurant_app/data/service/api_service.dart';
import 'package:restaurant_app/data/model/detail_restaurant.dart';
import 'package:restaurant_app/pages/review_page.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/provider/detail_restaurant_provider.dart';
import 'package:restaurant_app/provider/review_provider.dart';
import 'package:restaurant_app/widgets/custom_textfield.dart';
import 'package:restaurant_app/widgets/menu_tile.dart';

class DetailPage extends StatefulWidget {
  static const routeName = '/detail';

  final String id;

  DetailPage({required this.id});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  ScrollController controller = ScrollController();
  bool closeTopImage = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController reviewController = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        closeTopImage = controller.offset > 30;
      });
    });
  }

  daftarMakanan(DetailRestaurantItem restaurant) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          child: Text(
            'Daftar Makanan',
            style: blackText.copyWith(
              fontSize: 20,
              fontWeight: semiBold,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: restaurant.menus.foods.length,
          itemBuilder: (context, index) {
            return MenuTile(text: restaurant.menus.foods[index].name);
          },
        ),
        Divider(),
      ],
    );
  }

  daftarMinuman(DetailRestaurantItem restaurant) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          child: Text(
            'Daftar Minuman',
            style: blackText.copyWith(
              fontSize: 20,
              fontWeight: semiBold,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: restaurant.menus.drinks.length,
          itemBuilder: (context, index) {
            return MenuTile(text: restaurant.menus.drinks[index].name);
          },
        ),
        Divider(
          color: lightGreyColor,
          thickness: 1,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget customAppBar(DetailRestaurant restaurant) {
      return Consumer<DatabaseProvider>(
        builder: (context, favorite, _) {
          return FutureBuilder<bool>(
            future: favorite.isFavorited(restaurant.restaurant.id),
            builder: (context, snaphsot) {
              var isFavorited = snaphsot.data ?? false;
              return Container(
                margin: EdgeInsets.symmetric(
                  horizontal: defaultMargin,
                  vertical: 20,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    13,
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: closeTopImage ? 0 : 5,
                      sigmaY: closeTopImage ? 0 : 5,
                    ),
                    child: Container(
                      color: closeTopImage
                          ? Colors.transparent
                          : greyColor.withOpacity(.3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 20,
                              color: closeTopImage ? blackColor : whiteColor,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Detail Restaunrant',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: closeTopImage
                                  ? blackText.copyWith(
                                      fontSize: 16,
                                      fontWeight: semiBold,
                                    )
                                  : whiteText.copyWith(
                                      fontSize: 16,
                                      fontWeight: semiBold,
                                    ),
                            ),
                          ),
                          isFavorited
                              ? IconButton(
                                  onPressed: () => favorite.deleteFavorite(
                                    restaurant.restaurant.id,
                                  ),
                                  icon: Icon(
                                    Icons.favorite_rounded,
                                    size: 20,
                                    color: primaryColor,
                                  ),
                                )
                              : IconButton(
                                  onPressed: () {
                                    favorite.addFavorite(
                                      ListRestaurantItem.fromJson(
                                        restaurant.restaurant.toJson(),
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.favorite_border_rounded,
                                    size: 20,
                                    color:
                                        closeTopImage ? blackColor : whiteColor,
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      );
    }

    Widget topImage(DetailRestaurant restaurant) {
      return Hero(
        tag: restaurant.restaurant.pictureId,
        child: AnimatedContainer(
          width: double.infinity,
          height: closeTopImage ? 0 : 400,
          duration: Duration(milliseconds: 300),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                'https://restaurant-api.dicoding.dev/images/large/' +
                    restaurant.restaurant.pictureId,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }

    Widget details(DetailRestaurant restaurant) {
      return Consumer<ReviewProvider>(builder: (context, state, _) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.only(
            top: closeTopImage ? 70 : 380,
          ),
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(
                defaultRadius,
              ),
            ),
          ),
          child: ListView(
            controller: controller,
            physics: BouncingScrollPhysics(),
            children: [
              Container(
                padding: EdgeInsets.only(
                  left: defaultMargin,
                  right: defaultMargin,
                  top: defaultMargin,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            restaurant.restaurant.name,
                            overflow: TextOverflow.clip,
                            style: blackText.copyWith(
                              fontSize: 22,
                              fontWeight: semiBold,
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            restaurant.restaurant.address +
                                ", " +
                                restaurant.restaurant.city,
                            overflow: TextOverflow.clip,
                            style: greyText.copyWith(
                              fontWeight: medium,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ReviewPage.routeName,
                            arguments: state.customerReview,
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.star_rounded,
                                  color: primaryColor,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  restaurant.restaurant.rating.toString(),
                                  style: blackText.copyWith(
                                    fontSize: 16,
                                    fontWeight: semiBold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Lihat Review',
                              style: blackText.copyWith(
                                fontSize: 13,
                                fontWeight: medium,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: defaultMargin,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: defaultMargin,
                ),
                child: Text(
                  'Description',
                  style: blackText.copyWith(
                    fontSize: 22,
                    fontWeight: semiBold,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: defaultMargin,
                ),
                child: Text(
                  restaurant.restaurant.description,
                  textAlign: TextAlign.justify,
                  style: greyText.copyWith(
                    fontWeight: medium,
                    wordSpacing: 3,
                  ),
                ),
              ),
              SizedBox(
                height: defaultMargin,
              ),
              daftarMakanan(restaurant.restaurant),
              SizedBox(
                height: defaultMargin,
              ),
              daftarMinuman(restaurant.restaurant),
              SizedBox(
                height: defaultMargin,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: defaultMargin,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tulis Ulasan',
                      style: blackText.copyWith(
                        fontSize: 22,
                        fontWeight: semiBold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      hint: 'Name',
                      controller: nameController,
                    ),
                    CustomTextField(
                      hint: 'Ulasan',
                      controller: reviewController,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 120,
                        height: 50,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  defaultRadius,
                                ),
                              ),
                            ),
                          ),
                          onPressed: () {
                            state
                                .addReview(restaurant.restaurant.id,
                                    nameController.text, reviewController.text)
                                .then(
                              (value) {
                                Navigator.pushNamed(
                                  context,
                                  ReviewPage.routeName,
                                  arguments: value,
                                );
                                nameController.clear();
                                reviewController.clear();
                              },
                            );
                          },
                          child: Text(
                            'Kirim',
                            style: whiteText.copyWith(
                              fontWeight: semiBold,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      });
    }

    return ChangeNotifierProvider<DetailRestaurantProvider>(
      create: (_) =>
          DetailRestaurantProvider(apiService: ApiService(), id: widget.id),
      child: Consumer<DetailRestaurantProvider>(
        builder: (context, state, _) {
          return Scaffold(
            backgroundColor: whiteColor,
            body: state.state == DetailState.Loading
                ? Center(
                    child: SizedBox(
                      height: 120,
                      child: LoadingIndicator(
                        indicatorType: Indicator.ballClipRotateMultiple,
                        strokeWidth: 2,
                        colors: [primaryColor],
                      ),
                    ),
                  )
                : state.state == DetailState.HasData
                    ? SafeArea(
                        child: Stack(
                          children: [
                            topImage(state.detailRestaurant),
                            details(state.detailRestaurant),
                            customAppBar(state.detailRestaurant),
                          ],
                        ),
                      )
                    : state.state == DetailState.HasError
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 200,
                                  child: Image.asset(
                                    'images/no_connection_image.png',
                                    width: 100,
                                    height: 100,
                                  ),
                                ),
                                Text(
                                  'Koneksi internet terputus',
                                  style: blackText.copyWith(
                                    fontSize: 16,
                                    fontWeight: semiBold,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Center(
                            child: Text(
                              'Data tidak ditemukan!',
                              style: blackText.copyWith(
                                fontSize: 16,
                                fontWeight: semiBold,
                              ),
                            ),
                          ),
          );
        },
      ),
    );
  }
}
