import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tidapartners/utils/colors.dart';

import '../../../../utils/common_utils.dart';

class ContactBar extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;

  const ContactBar({Key? key, this.onPressed, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.0.w, vertical: 10.h),
      child: TextButton(
        onPressed: () {
          makePhoneCall("+918195944444");
        },
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0.r),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(
            kPrimaryColor,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.phone,
              color: kWhiteColor,
              size: 16.0.sp,
            ),
            SizedBox(width: 10.w),
            Text(
              text,
              style: TextStyle(
                color: kWhiteColor,
                fontSize: 12.0.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
