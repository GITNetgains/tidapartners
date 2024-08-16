import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tidapartners/utils/colors.dart';

class SideHeadingWidget extends StatelessWidget {
  const SideHeadingWidget(
      {super.key, required this.name, this.onTap, this.view = false, this.fontSize = 18});
  final Function()? onTap;
  final String name;
  final double fontSize;
  final bool view;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: TextStyle(
              fontSize: fontSize.sp,
              color: kHeadingColor,
              fontWeight: FontWeight.bold),
        ),
        view
            ? GestureDetector(
                onTap: onTap,
                child: Text(
                  "view all",
                  style: TextStyle(color: kPrimaryColor),
                ))
            : SizedBox.shrink()
      ],
    );
  }
}
