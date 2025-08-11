import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:teacher/core/resource/colors_manager.dart';

class MovingContainer extends StatelessWidget {
  const MovingContainer({super.key, required this.iconData, required this.ontap});
final Icon iconData;
final GestureTapCallback ontap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        width: 40,
        height: 25,
        decoration: BoxDecoration(
      color: darkGreen,
      borderRadius: BorderRadius.all(Radius.circular(5))
      
        ),
        child:iconData ,
      ),
    );
  }
}