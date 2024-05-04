import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tidapartners/utils/colors.dart';

class SideHeadingWidget extends StatelessWidget {
  const SideHeadingWidget({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: TextStyle(
          fontSize: 18.sp, color: kHeadingColor, fontWeight: FontWeight.bold),
    );
  }
}
