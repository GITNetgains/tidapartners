import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tidapartners/utils/colors.dart';

class UniversalButton extends StatelessWidget {
  const UniversalButton(
      {super.key, required this.name, required this.function, this.fontSize});

  final String name;
  final Function() function;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.all(4.dg),
      decoration: BoxDecoration(color: kSecondaryColor,borderRadius: BorderRadius.circular(5.r)),
      child: GestureDetector(
        onTap: function,
        child: Text(
          name,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: fontSize ?? 12.sp),
        ),
      ),
    );
  }
}
