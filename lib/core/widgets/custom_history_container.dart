import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teacher/core/resource/assets_manager.dart';
import 'package:teacher/core/resource/colors_manager.dart';
import 'package:teacher/core/resource/icon_image_manager.dart';
import 'package:teacher/icons_flutter_icons.dart';

// mintGreen2
// threecircle
class CustomHistoryContainer extends StatelessWidget {
   CustomHistoryContainer({super.key, 
   required this.atendance, required this.fromSurahName, required this.fromAyah, required this.toSurahName, required this.toAyah});
final String atendance;
 final String fromSurahName;
final num fromAyah;
 final String toSurahName;
final num toAyah;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Stack(
       // clipBehavior: Clip.hardEdge,
        children: [
          Container(
            width: 250.w,
            height: 175.h,
            decoration: BoxDecoration(color: mintGreen2,
            borderRadius: BorderRadius.circular(15)
            ),
            
            child: Column(
              
              crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                Row(children: [ Image.asset(IconImageManager.star,width: 30,height: 30,),
               Text("حضور: ${atendance }")
                
                ,],),
                
                Row(
                  children: [
                  //  Icon(IconsFlutter.star),
                   Image.asset(IconImageManager.star,width: 30,height: 30,),
            
                    Text("تسميع قرآن:"),
                  ],
                ),
               Padding(
                 padding: const EdgeInsets.only(right: 30),
                 child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  
                   Row(
                    children: [
                      Text(":من سورة "),
                      Text("$fromSurahName"),
                    
                    ],
                  ),
                  Row(children: [  Text("من الاية "),
                      Text("$fromAyah")],),
                  Row(
                    children: [
                      Text("الى سورة "),
                      Text("$toSurahName"),
                     
                    ],
                  ),
                  Row(children: [ Text("الى الاية "),
                      Text("$toAyah")],)
                 ],),
               )
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: -5.5,
              //alignment: Alignment.bottomLeft,
              child: Image.asset(ImagesManager.threecircle,
              height: 30,
              width: 40,
              ))
        ],
      ),
    );
  }
}
