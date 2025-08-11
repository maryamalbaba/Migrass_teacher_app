import 'package:flutter/material.dart';
import 'package:teacher/core/resource/colors_manager.dart';

import '../../../../core/resource/assets_manager.dart';
import '../../../../core/resource/icon_image_manager.dart';

class SessionCard extends StatelessWidget {
  final String title;
  final String subtitle;

  final VoidCallback onTap;

  const SessionCard({
    super.key,
    required this.title,
    required this.subtitle,

    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 6,
              offset: const Offset(10, 10),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
            SizedBox(
            height: 60,
            width: 60,
              child: Icon(Icons.mosque_rounded,color: lightGreen1,),
              // child: Image.network(
              //     fit: BoxFit.cover,
              //     ImagesManager.iconmsg,
              //    ),
            ),

          ],
        ),
      ),
    );
  }
}
