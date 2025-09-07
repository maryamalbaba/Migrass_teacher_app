import 'package:flutter/material.dart';

class SoftAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SoftAppBar({
    super.key,
    required this.title,
    this.onBack,
    this.backgroundColor = const Color(0xFFCFE5D5), // أخضر فاتح مثل الصورة
    this.iconBgColor = Colors.white,
    this.iconColor = const Color(0xFF6B8F78),        // أخضر أغمق للسهم
    this.elevation = 0,
  });

  final String title;
  final VoidCallback? onBack;
  final Color backgroundColor;
  final Color iconBgColor;
  final Color iconColor;
  final double elevation;

  @override
  Size get preferredSize => const Size.fromHeight(72);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      elevation: elevation,
      child: SafeArea(
        bottom: false,
        child: Container(
          height: preferredSize.height,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2F3E35), // نص داكن قليلًا
                  ),
                ),
              ),
              // للموازنة البصرية مع زر الرجوع (مساحة فارغة بنفس العرض)
              const SizedBox(width: 44),
              _BackSquareButton(
                onTap: onBack ?? () => Navigator.maybePop(context),
                bg: iconBgColor,
                iconColor: iconColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BackSquareButton extends StatelessWidget {
  const _BackSquareButton({
    required this.onTap,
    required this.bg,
    required this.iconColor,
  });

  final VoidCallback onTap;
  final Color bg;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(12);
    return Container(
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        shadowColor: Colors.grey,
        color: bg,
        borderRadius: radius,
        elevation: 0,
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: Container(
            width: 44,
            height: 44,

            alignment: Alignment.center,
            child: Icon(
              Icons.arrow_forward_ios,
              size: 22,
              color: iconColor,
            ),
          ),
        ),
      ),
    );
  }
}
