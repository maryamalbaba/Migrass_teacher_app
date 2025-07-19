import 'package:flutter/material.dart';
import 'package:teacher/core/resource/assets_manager.dart';
import 'package:teacher/core/resource/colors_manager.dart';
import 'package:teacher/core/widgets/green_container.dart';

class tasmi3UI extends StatelessWidget {
  const tasmi3UI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//lightGreen2
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(color: lightGreen2),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
           mainAxisAlignment: MainAxisAlignment.end,
            children: [
           
            Container(
              
            
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    width: 130,
                    height: 70,
                    ImagesManager.lamp),
                  Row( children: [ ElevatedButton(onPressed: (){}, child: Text("l")),
                  Text("mkm"),
                  ElevatedButton(onPressed: (){}, child: Text("k"))
                  ],
                  
                  )
                ],
              ),
            ),   Image(
                
                image: AssetImage(ImagesManager.moon , )),
          
            
            ],
                   
                   
          ),
          
           
            
               Expanded(
                 child: Container(
                  
                  width: MediaQuery.of(context).size.width ,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(color: white,
                  borderRadius: BorderRadius.only(topLeft:Radius.circular(25) ,topRight: Radius.circular(25))
                 
                  ),
                 
                 ),
               )
        ],
      ),
    ));
  }
}
