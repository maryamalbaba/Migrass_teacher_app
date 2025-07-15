import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../resource/colors_manager.dart';

void showCustomSnackBar(
    BuildContext context, {
      required String message,
      bool isError = false,

    }) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Icon(
            isError ? Icons.error_outline : Icons.check_circle_outline,
            color: Colors.white,
            size: 24,
          ),
        ],
      ),
      backgroundColor: isError ? Colors.red.shade400 : greenLight,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      elevation: 8,
      duration: Duration(seconds: 3),


    ),
  );
}