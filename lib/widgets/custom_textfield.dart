import 'package:flutter/material.dart';
import '../utilities/style.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;
  final Widget? icon;
  final String? hint;
  final double width;
  final double? height;

  CustomTextField({
    required this.controller,
    this.onChanged,
    this.icon,
    this.hint,
    this.width = double.infinity,
    this.height,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      margin: EdgeInsets.only(
        bottom: defaultMargin,
        top: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          defaultRadius,
        ),
        boxShadow: [
          BoxShadow(
            color: blackColor.withOpacity(0.2),
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: TextField(
        controller: widget.controller,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          fillColor: lightGreyColor,
          filled: true,
          hintText: widget.hint,
          prefixIcon: widget.icon,
          suffixIcon: widget.controller.text.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      widget.controller.clear();
                      widget.onChanged!('');
                    });
                  },
                  icon: Icon(
                    Icons.clear_rounded,
                    color: greyColor,
                  ),
                )
              : SizedBox(),
          contentPadding: EdgeInsets.symmetric(
            horizontal: defaultMargin,
            vertical: 16,
          ),
          hintStyle: greyText.copyWith(
            fontWeight: medium,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(
              defaultRadius,
            ),
          ),
        ),
      ),
    );
  }
}
