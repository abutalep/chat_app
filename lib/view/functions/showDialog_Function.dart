import 'package:flutter/material.dart';

void showDialog_Function(BuildContext context, {required String title,required String content}) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(content),
      ),
    );
  }