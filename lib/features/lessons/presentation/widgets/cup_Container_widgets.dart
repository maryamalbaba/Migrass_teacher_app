import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/resource/assets_manager.dart';

class CupContainer extends StatelessWidget {
  const CupContainer({Key? key}) : super(key: key);

  Future<void> _openWebsite(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("تعذر فتح الرابط: $url");
    }
  }




  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 150,
      width: 400,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImagesManager.cupContainer),
          fit: BoxFit.fill,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'التحديات',
                style: TextStyle(fontSize: 30,fontFamily: "ArefRuqaa"),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _openWebsite("http://localhost:53114/");                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                ),
                child: const Text(
                  "افتح",
                  style: TextStyle(fontSize: 18,color: Colors.orange),
                ),
              ),
            ],
          ),
          Image.asset(
            ImagesManager.cup,
            width: 150,
            height: 200,
          ),
        ],
      ),
    );
  }
}