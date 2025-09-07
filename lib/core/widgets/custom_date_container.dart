import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teacher/core/resource/colors_manager.dart';
import 'package:teacher/core/widgets/green_container.dart';

class CustomDateContainer extends StatelessWidget {
  const CustomDateContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        height: 42.h,
        width: 77.w,
        decoration: BoxDecoration(
          color: greenGray,
          borderRadius: BorderRadius.circular(6)
          
        ),
        child: Column(
          children: [
            Text("الاحد",style: TextStyle(fontSize: 15),),
            Text("2025-2-1",style:TextStyle(fontSize: 10) ,)
          ],
        ),
      ),
    );
  }
}