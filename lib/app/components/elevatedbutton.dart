import 'package:flutter/material.dart';
import '../../utils/colors.dart';

class MyButton extends StatelessWidget {
  const MyButton({super.key, required this.ontap, required this.text});

  final void Function () ? ontap;
  final String text;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        margin:const  EdgeInsets.only(left: 50 , right: 50, top:40, bottom:10),
        decoration: BoxDecoration(
          color: kSecondaryColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(text,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
              color: Colors.white
            ),),
          ),
        ),
      ),
    );
  }
}
