import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:teacher/core/resource/assets_manager.dart';
import 'package:teacher/core/resource/colors_manager.dart';

class RecordsUi extends StatelessWidget {
  RecordsUi({super.key});
  AudioPlayer player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
             width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.34,
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)
                    
                    ),
                    image: DecorationImage(image: AssetImage("assets/images/cute.png"),
                    
                    fit: BoxFit.fill,
                    )
                    ),
           
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent, // يخفي الخط الفاصل التلقائي
                splashColor: Colors.transparent, // يخفي تأثير الضغط
                highlightColor: Colors.transparent,
              ),
              child: ExpansionTile(
                title: Text("مريم البابا"),
                expandedAlignment: Alignment.centerLeft,
                children: [
                  Row(
                    children: [
                      Slider(value: 2, min: 0, max: 10, onChanged: (value) {}),
                      IconButton(
                          onPressed: () {
                            player.setSourceUrl(
                                "http://www.soundjay.com/phone/phone-ring-1.mp3");
                          },
                          icon: Icon(Icons.play_arrow))
                    ],
                  ),
                  Divider(
                    color: const Color.fromARGB(255, 183, 183, 183),
                    indent: 20,
                    endIndent: 20,
                  ),
                  Text("سورة ق من الاية 1 الى الاية 20"),
                  Divider(
                    color: const Color.fromARGB(255, 183, 183, 183),
                    indent: 20,
                    endIndent: 20,
                  ),
                  Row(
                    children: [
                      Text("تقييم"),
                      Spacer(),
                    ],
                  ),
                  Divider(
                    color: const Color.fromARGB(255, 183, 183, 183),
                    indent: 20,
                    endIndent: 20,
                  ),
                  Text("ارسال ملاحظات"),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("ارسال"),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
