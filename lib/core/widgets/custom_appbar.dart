import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../resource/colors_manager.dart';
import '../resource/navigator_manager.dart';


class CustomAppbar extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final bool showBackButton;

  const CustomAppbar({
    Key? key,
    required this.title,
    this.onTap,
    this.showBackButton = true,


  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:12 ,vertical: 20.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Text(title,style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: black,
               ),),
            showBackButton?  InkWell(child:Icon(Icons.arrow_forward_ios,color: gray,size: 22,),
              onTap: (){
                AppNavigator.instance.pop();
              },
            ):SizedBox.shrink(),
          ],
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