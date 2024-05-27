import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/common_utils.dart';

class ContactBar extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;

  const ContactBar({Key? key, this.onPressed, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 50.0.w,vertical: 10.h),
      child: TextButton(
        onPressed: (){
                    makePhoneCall("+918195944444");
        },
        style: ButtonStyle(
          side: MaterialStateProperty.all<BorderSide>(
            BorderSide(color: Colors.red),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(
            Colors.transparent,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.phone,
              color: Colors.red,
              size: 16.0,
            ),
            SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                color: Colors.blue[900],
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
