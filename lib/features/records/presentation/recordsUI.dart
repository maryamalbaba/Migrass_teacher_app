// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:teacher/core/resource/api_manager.dart';

import 'package:teacher/core/resource/assets_manager.dart';
import 'package:teacher/core/resource/colors_manager.dart';
import 'package:teacher/features/records/data/repo/recordrepo.dart';
import 'package:teacher/features/records/data/source/remote/get_remot_record.dart';
import 'package:teacher/features/records/domain/usecase/record_usecase.dart';
import 'package:teacher/features/records/presentation/bloc/record_bloc.dart';

class RecordsUi extends StatefulWidget {
  RecordsUi({super.key});

  @override
  State<RecordsUi> createState() => _RecordsUiState();
}

class _RecordsUiState extends State<RecordsUi> {
  String url = "http://127.0.0.1:4000/api/";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          RecordBloc(GetRecordsUseCase(RecordRepository(GetRemotRecord())))
            ..add(FetchRecords()),
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ✅ صورة الهيدر
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.34,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  image: DecorationImage(
                    image: AssetImage("assets/images/cute.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),

              //
              BlocBuilder<RecordBloc, RecordState>(
                builder: (context, state) {
                  if (state is RecordLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is RecordLoaded) {
                    if (state.records.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text("لا يوجد تسجيلات صوتية"),
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true, // ✅ يخليها تتمدد بالحجم المطلوب
                      physics:
                          const NeverScrollableScrollPhysics(), // ✅ يمنع scroll داخلي
                      itemCount: state.records.length,
                      itemBuilder: (context, index) {
                        return CardRecord(
                          name: state.records[index].studentaudio.first_name +
                              state.records[index].studentaudio.last_name,
                          path: ApiManager.baseUrl +
                              //url+
                              state.records[index].file,
                          from_aya: state.records[index].from_ayah_id,
                          to_aya: state.records[index].to_ayah_id,
                          suraname: state.records[index].sura_record.name,
                        );
                      },
                    );
                  } else if (state is RecordError) {
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text("خطأ: ${state.message}"),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardRecord extends StatefulWidget {
  final String name;
  final String path;
  final num from_aya;
  final num to_aya;
  final String suraname;
  CardRecord({
    Key? key,
    required this.name,
    required this.path,
    required this.from_aya,
    required this.to_aya,
    required this.suraname,
  }) : super(key: key);

  @override
  State<CardRecord> createState() => _CardRecordState();
}

class _CardRecordState extends State<CardRecord> {
  AudioPlayer player = AudioPlayer();

  double value = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          splashColor: Colors.transparent,
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
              title: Text(widget.name),
              expandedAlignment: Alignment.centerLeft,
              childrenPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  player.setSourceUrl(widget.path);
                                  player.resume();
                                },
                                icon: const Icon(Icons.play_circle),
                              ),
                              Expanded(
                                child: Slider(
                                  value: 2,
                                  min: 0,
                                  max: 10,
                                  onChanged: (value) {},
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            color: Color.fromARGB(255, 183, 183, 183),
                            indent: 20,
                            endIndent: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 4),
                            child: Text(
                              " ${widget.suraname} سورة  ${widget.to_aya} الى الاية ${widget.from_aya} من اية ",
                              style: TextStyle(fontSize: 10),
                              textAlign: TextAlign.right,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Divider(
                            color: Color.fromARGB(255, 183, 183, 183),
                            indent: 20,
                            endIndent: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text("تقييم"),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  RatingStars(
                                    value: value,
                                    onValueChanged: (v) {
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
                                    valueLabelRadius: 10,
                                    starSpacing: 2, // Reduced from 2 to 1
                                    maxValueVisibility: true,
                                    valueLabelVisibility: false,
                                    animationDuration:
                                        const Duration(milliseconds: 1000),
                                    valueLabelPadding:
                                        const EdgeInsets.symmetric(
                                            vertical: 1, horizontal: 8),
                                    valueLabelMargin:
                                        const EdgeInsets.only(right: 8),
                                    starOffColor: const Color(0xffe7e8ea),
                                    starColor: Colors.yellow,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Divider(
                            color: Color.fromARGB(255, 183, 183, 183),
                            indent: 20,
                            endIndent: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: "ارسال ملاحظات",
                                hintStyle: TextStyle(fontSize: 12, color: gray),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: ElevatedButton(
                              onPressed: () {},
                              child: const Center(child: Text("ارسال")),
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
