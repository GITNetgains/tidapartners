import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tidapartners/utils/colors.dart';

class BookingWidget extends StatelessWidget {
  const BookingWidget(
      {super.key,
      required this.image,
      required this.name,
      required this.number,
      required this.color});

  final String image, name;
  final int number;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      margin:  EdgeInsets.symmetric(horizontal: 2.w),
      padding:  EdgeInsets.symmetric(horizontal: 10.h,vertical: 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: color,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(image,width: 40.w,height: 40.h,),
           SizedBox(height: 10.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                number.toString(),
                style: TextStyle(
                  fontSize: 25.sp,
                  color: kHeadingColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12.sp,
                  letterSpacing: -1,
                  color: kHeadingColor,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          )
        ],
      ),
    ));
  }
}
