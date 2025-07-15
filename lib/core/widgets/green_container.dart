import 'package:flutter/material.dart';
import 'package:teacher/core/resource/colors_manager.dart';
import 'package:teacher/core/resource/icon_image_manager.dart';
import 'package:teacher/core/resource/assets_manager.dart';
import 'package:teacher/core/resource/string_manager.dart';

class greenContainer extends StatelessWidget {
  const greenContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 130,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), 
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            )
          ],
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
              begin: Alignment.topCenter, colors: [sofgreen, greenGray])),
      child: Column(
        children: [
          Text("2025-6-6",
              style: TextStyle(color: white, fontWeight: FontWeight.bold)),
          Align(
            child: Padding(
                padding: EdgeInsets.all(7),
                child: Text("  حلقة تبارك",
                    style:
                        TextStyle(color: white, fontWeight: FontWeight.bold))),
            alignment: Alignment.bottomRight,
          ),
          Spacer(),
          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset(ImagesManager.tower, height: 66),
          )
        ],
      ),
    );
  }
}
