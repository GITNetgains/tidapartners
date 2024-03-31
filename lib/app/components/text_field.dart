import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTextField extends StatefulWidget {
  const MyTextField({
    Key? key,
    required this.firstImage,
    required this.firstText,
    required this.hintText,
    required this.isPassword,
    required this.textController,
    this.textInputFormatters,
    this.keyboardType = TextInputType.name,
    this.isObscure = false,
     this.suffixIcon,
  }) : super(key: key);

  final String firstImage;
  final String firstText;
  final String hintText;
  final bool isObscure;
  final bool isPassword;
  final Widget? suffixIcon;
  final TextEditingController textController;
  final List<TextInputFormatter>? textInputFormatters;
  final TextInputType keyboardType;

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                widget.firstImage,
                width: 15,
                height: 15,
              ),
              const SizedBox(width: 8),
              Text(
                widget.firstText,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
              border: Border.all(
                color: isFocused ? Colors.grey : Colors.white,
                width: 2,
              ),
            ),
            child: TextField(
              obscureText: widget.isObscure,
              controller: widget.textController,
              inputFormatters: widget.textInputFormatters,
              keyboardType: widget.keyboardType,
              textInputAction: TextInputAction.next,
              onSubmitted: (value) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              decoration: InputDecoration(
                suffixIcon: widget.suffixIcon,
                hintText: widget.hintText,
                hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 20.w, top: widget.isPassword ? 10.h : 0.h),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
