import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/page_provider.dart';
import 'package:restaurant_app/common/style.dart';

class CustomNavBar extends StatefulWidget {
  @override
  _CustomNavBarState createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  Widget navBarIcon(int index, IconData icon) {
    return Consumer<PageProvider>(
      builder: (context, state, _) => InkWell(
        onTap: () {
          setState(() {
            state.currentIndex = index;
          });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 250),
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: state.currentIndex == index ? 90 : 45,
          height: 40,
          decoration: BoxDecoration(
            color:
                state.currentIndex == index ? primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(70),
          ),
          child: Icon(
            icon,
            color: state.currentIndex == index ? whiteColor : greyColor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - (2 * defaultMargin),
      height: 70,
      decoration: BoxDecoration(
        color: lightGreyColor,
        borderRadius: BorderRadius.circular(70),
        boxShadow: [
          BoxShadow(
            color: blackColor.withOpacity(0.2),
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          navBarIcon(0, Icons.home_rounded),
          navBarIcon(1, Icons.favorite_rounded),
          navBarIcon(2, Icons.settings_rounded),
        ],
      ),
    );
  }
}
