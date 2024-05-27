import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BookNow extends StatelessWidget {
  const BookNow({Key? key, required this.function, required this.name});

  final String name;

  final Function()? function;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: function,
        child: Text(
          name,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.0.sp,
          ),
        ),
        style: ButtonStyle(
          fixedSize: MaterialStateProperty.all(Size(Get.width/1.1, 40.h)),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0.r),
            ),
          ),
        ),
      ),
    );
  }
}
