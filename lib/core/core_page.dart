import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teacher/core/resource/colors_manager.dart';
import 'package:teacher/core/resource/icon_image_manager.dart';
import 'package:teacher/features/lessons/presentation/homePage.dart';
import 'package:teacher/features/records/presentation/recordsUI.dart';
import 'package:teacher/features/tasmi3/presentation/view/tasmi3.dart';
import 'package:teacher/my_flutter_app_icons.dart';

class CoreUi extends StatefulWidget {
  CoreUi({super.key});

  @override
  State<CoreUi> createState() => _CoreUiState();
}

class _CoreUiState extends State<CoreUi> {
  List<Widget> page = [Homepage(), RecordsUi(), tasmi3UI()];

  int index = 0;

  List<String> IconList = [];

  final List<TabItem> items = [
    TabItem( icon: MyFlutterApp.home,
        
        // SvgPicture.asset(
        //   IconImageManager.home_svg,
        //   width: 24,
        //   height: 24,
        // ),
        title: 'الرئيسية'),
    TabItem(icon: MyFlutterApp.icon_report, title: 'بحث'),
    TabItem(icon: MyFlutterApp.mic_circled, title: 'تسميعات'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: page[index],
        bottomNavigationBar: BottomBarDefault(
          indexSelected: index,
          items: items,
          backgroundColor: white,
          color: grayDark,
          colorSelected: green,
          onTap: (value) => {
            setState(() {
              
            index=value;
            })
          },
        ));
  }
}
