import 'package:flutter/material.dart';
import 'package:restaurant_app/common/style.dart';

class ReviewCard extends StatelessWidget {
  final String name;
  final String date;
  final String review;

  ReviewCard({
    required this.name,
    required this.date,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: primaryColor,
                child: Icon(
                  Icons.person,
                  color: whiteColor,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: blackText.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    date,
                    style: greyText.copyWith(
                      fontSize: 12,
                      fontWeight: medium,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            width: double.infinity,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  defaultRadius,
                ),
              ),
              margin: EdgeInsets.symmetric(
                vertical: 25,
              ),
              child: Padding(
                padding: EdgeInsets.all(
                  defaultMargin,
                ),
                child: Text(
                  review,
                  style: blackText.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
              ),
            ),
          ),
          Divider(
            height: 20,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
