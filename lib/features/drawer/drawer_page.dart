import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teacher/core/resource/colors_manager.dart';
import 'package:teacher/core/resource/navigator_manager.dart';
import 'package:teacher/core/resource/route_const.dart';
import 'package:teacher/core/widgets/custom_appbar.dart';

import '../../core/resource/assets_manager.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        margin: EdgeInsets.only(top: 40),
        decoration: BoxDecoration(
          color: white,
          image: DecorationImage(
            image: AssetImage(
              ImagesManager.drawer,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            CustomAppbar(title: '',showBackButton: true,),
            SizedBox(
              height: 250,
            ),
            MenuPill(
              title: 'ملف شخصي',
              icon: Icons.person_outline,
              onTap: () {
                AppNavigator.instance.push(name: RouteConst.profile);
              },
            ),
            const SizedBox(height: 16),
            MenuPill(
              title: 'احصائيات الطلبة',
              icon: Icons.stacked_bar_chart_outlined,
              onTap: () {},
            ),
            const SizedBox(height: 16),
            MenuPill(
              title: 'ادخال علامات الطلبة',
              icon: Icons.insert_drive_file_outlined,
              onTap: () {
                AppNavigator.instance.push(name: RouteConst.circleExam);

              },
            ),
            const SizedBox(height: 16),
            MenuPill(
              title: 'شارك التطبيق',
              icon: Icons.reply, // السهم للخلف
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class MenuPill extends StatelessWidget {
  const MenuPill({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(15);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Material(
        color: Colors.white.withOpacity(0.5),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: radius),
        child: InkWell(
          borderRadius: radius,
          onTap: onTap,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 68),
            child: Directionality( // يضمن محاذاة RTL
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 12),
                    Icon(icon, size: 28, color: const Color(0xFF6D6D6D)),
                    const SizedBox(width: 12),

                    Text(
                      title,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF4A4A4A),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
