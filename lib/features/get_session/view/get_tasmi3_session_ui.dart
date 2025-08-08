import 'package:flutter/material.dart';
import 'package:teacher/core/resource/assets_manager.dart';
import 'package:teacher/core/resource/colors_manager.dart';
import 'package:teacher/core/resource/icon_image_manager.dart';

class Tasmi3SessionUi extends StatelessWidget {
  const Tasmi3SessionUi({super.key});

  @override
  Widget build(BuildContext context) {
    final double stackHeight = MediaQuery.of(context).size.height * 0.20;
    return Scaffold(
      backgroundColor: lightGreen2,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: stackHeight,
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Image.asset(
                      ImagesManager.greenBcak,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: stackHeight - 16.0, // Subtract padding height
                            width: MediaQuery.of(context).size.width * 0.40,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "حلقة تبارك",
                                    style: TextStyle(fontSize: 15),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "2023-03-03",
                                    style: TextStyle(fontSize: 12),
                                    maxLines: 1,
                                   // overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Align(
                        alignment: Alignment.topLeft,
                        child: const backContainer()),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class backContainer extends StatelessWidget {
  const backContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 30,
        width: 30,
        decoration: const BoxDecoration(
          color: white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Center(
          child: Image.asset(IconImageManager.back),
        ),
      ),
    );
  }
}