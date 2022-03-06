import 'package:flutter/material.dart';
import '../utilities/style.dart';

class MenuTile extends StatelessWidget {
  final String text;

  const MenuTile({required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: lightGreyColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          defaultRadius,
        ),
      ),
      margin: EdgeInsets.only(
        bottom: 16,
        right: defaultMargin,
        left: defaultMargin,
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
          style: blackText.copyWith(
            fontSize: 16,
            fontWeight: medium,
          ),
        ),
      ),
    );
  }
}
