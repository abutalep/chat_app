import 'package:chat_app/constant/app_colors.dart';
import 'package:flutter/material.dart';

class CustomSendTextField extends StatelessWidget {
  String hintText;
  Function(String) onSubmitted;
  void Function() onPressed;
  TextEditingController controller;
  CustomSendTextField(
      {required this.hintText, required this.onSubmitted,required this.onPressed,required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: AppColor.primaryColor),
      controller: controller,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: AppColor.primaryColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: AppColor.primaryColor,
            ),
          ),
          suffixIcon: IconButton(
            icon: const Icon(Icons.send),
            
            color: AppColor.primaryColor,
            onPressed: onPressed,
          )),
    );
  }
}
