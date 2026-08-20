import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final void Function()? onTap;
  final Icon suffixicon;
  final TextEditingController? controller;
  final void Function(String)? onSubmitted;
  final TextInputAction? textInputAction;

  const CustomTextField({
    super.key,
    required this.suffixicon,
    required this.hintText,
    required this.onTap,
    this.controller,
    this.onSubmitted,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onSubmitted: onSubmitted,
      textInputAction: textInputAction ?? TextInputAction.search,
      style: const TextStyle(color: Colors.black),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        labelStyle: const TextStyle(color: Colors.black),
        hintStyle: const TextStyle(color: Colors.black),
        prefixIcon: const Icon(Icons.search),
        fillColor: const Color(0xffFAFAF9),
        focusColor: Colors.black,
        suffixIcon: InkWell(
          onTap: onTap,
          child: const Icon(Icons.mic, color: Color(0xffFFC899)),
        ),
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.r)),
      ),
    );
  }
}
