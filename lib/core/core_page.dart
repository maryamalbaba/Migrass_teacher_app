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
  List<Widget> page = [ RecordsUi(),tasmi3UI(),Homepage(), ];

  int index = 2;

  List<String> IconList = [];

  final List<TabItem> items = [
    TabItem( icon: MyFlutterApp.mic_circled,
        
        // SvgPicture.asset(
        //   IconImageManager.home_svg,
        //   width: 24,
        //   height: 24,
        // ),
        title: 'تسجيلات'),
    TabItem(icon: MyFlutterApp.icon_report, title: 'تسميعات'),
    TabItem(icon: MyFlutterApp.home, title: 'الرئيسية'),
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
