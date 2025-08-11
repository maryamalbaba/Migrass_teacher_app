import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:teacher/core/resource/assets_manager.dart';
import 'package:teacher/core/resource/colors_manager.dart';

class RecordsUi extends StatefulWidget {
  RecordsUi({super.key});

  @override
  State<RecordsUi> createState() => _RecordsUiState();
}

class _RecordsUiState extends State<RecordsUi> {
  AudioPlayer player = AudioPlayer();

  double value = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.34,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              image: const DecorationImage(
                image: AssetImage("assets/images/cute.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors
                    .transparent, //  بيخفي الخط الفاصل التلقائي لمشا ما يطلعلي معلم
                splashColor: Colors.transparent, //  بيخفي تأثير الضغط
                highlightColor: Colors.transparent,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Card(
                  color: white,
                  child: ExpansionTile(
                    title: const Text("مريم البابا"),
                    expandedAlignment: Alignment.centerLeft,
                    childrenPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    children: [
                      Row(
                        children: [
                          Expanded(
                            
                            child:Column(
crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
children: [

                          
                          IconButton(
                            onPressed: () {
                              // player.setSourceUrl(
                              //     "http://www.soundjay.com/phone/phone-ring-1.mp3");

                              player.setSource(
                                  AssetSource('sounds/1B6OkGDfBEw.mp3'));

                              player.resume();
                            },
                            icon: const Icon(Icons.play_circle),
                          ),
                          
   Slider(
                              value: 2,
                              min: 0,
                              max: 10,
                              onChanged: (value) {},
                            ),
],

                                ),
                              
                        
                      
                       Divider(
                        color: Color.fromARGB(255, 183, 183, 183),
                        indent: 20,
                        endIndent: 20,
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        child: Text("سورة ق من الاية 1 الى الاية 20",style: TextStyle(fontSize: 10),
                         textAlign: TextAlign.right,
                        ),
                      ),
                      const Divider(
                        color: Color.fromARGB(255, 183, 183, 183),
                        indent: 20,
                        endIndent: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children:  [
                            Text("تقييم"),
                            Spacer(),
                            RatingStars(
                              value: value,
                              onValueChanged: (v) {
                                //
                                setState(() {
                                  value = v;
                                });
                              },
                              starBuilder: (index, color) => Icon(
                                Icons.star,
                                color: color,
                              ),
                              starCount: 5,
                              starSize: 20,
                              valueLabelColor: const Color(0xff9b9b9b),
                              // valueLabelTextStyle: const TextStyle(
                              //     color: Colors.white,
                              //     fontWeight: FontWeight.w400,
                              //     fontStyle: FontStyle.normal,
                              //     fontSize: 12.0),
                              valueLabelRadius: 10,
                              //maxValue: 5,
                              starSpacing: 2,
                              maxValueVisibility: true,
                              valueLabelVisibility: false,
                              animationDuration: Duration(milliseconds: 1000),
                              valueLabelPadding: const EdgeInsets.symmetric(
                                  vertical: 1, horizontal: 8),
                              valueLabelMargin: const EdgeInsets.only(right: 8),
                              starOffColor: const Color(0xffe7e8ea),
                              starColor: Colors.yellow,
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Color.fromARGB(255, 183, 183, 183),
                        indent: 20,
                        endIndent: 20,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "ارسال ملاحظات",
                            hintStyle: TextStyle(
                              fontSize: 12,
                              color: gray
                            )
                          ),
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Center(child: const Text("ارسال")),
                        ),
                      ),
                      const SizedBox(height: 8),
                              
                        ]),
                      )                            
                       ]   )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
