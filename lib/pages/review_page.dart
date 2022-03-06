import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/detail_restaurant.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/widgets/review_card.dart';

class ReviewPage extends StatelessWidget {
  static const routeName = '/review';

  final Review review;

  ReviewPage({required this.review});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        physics: BouncingScrollPhysics(),
        headerSliverBuilder: (context, isScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 55,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  'Review',
                  style: blackText.copyWith(
                    fontWeight: semiBold,
                    fontSize: 22,
                  ),
                ),
                titlePadding: EdgeInsets.symmetric(
                  horizontal: defaultMargin,
                ),
              ),
            ),
          ];
        },
        body: ListView.builder(
          padding: EdgeInsets.all(
            defaultMargin,
          ),
          physics: BouncingScrollPhysics(),
          itemCount: review.customerReviews.length,
          itemBuilder: (context, index) {
            final reviewList = review.customerReviews[index];
            return ReviewCard(
              name: reviewList.name,
              date: reviewList.date,
              review: reviewList.review,
            );
          },
        ),
      ),
    );
  }
}
