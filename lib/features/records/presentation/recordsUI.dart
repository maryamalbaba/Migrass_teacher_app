// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teacher/core/resource/api_manager.dart';
import 'package:teacher/core/resource/colors_manager.dart';
import 'package:teacher/core/widgets/custom_date_container.dart';
import 'package:teacher/features/records/data/repo/recordrepo.dart';
import 'package:teacher/features/records/data/source/remote/get_remot_record.dart';
import 'package:teacher/features/records/domain/usecase/record_usecase.dart';
import 'package:teacher/features/records/presentation/bloc/record_bloc.dart';
import 'package:teacher/features/value_record/data/models/value_model.dart';
import 'package:teacher/features/value_record/data/repo/repoimp.dart';


import 'package:teacher/features/value_record/data/source/remote.dart';
import 'package:teacher/features/value_record/domain/usecase/record_usecase.dart';

import 'package:teacher/features/value_record/presentation/bloc/value_record_bloc.dart';

class RecordsUi extends StatefulWidget {
  RecordsUi({super.key});

  @override
  State<RecordsUi> createState() => _RecordsUiState();
}

class _RecordsUiState extends State<RecordsUi> {
//  String url = "http://127.0.0.1:4000/api/";
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              RecordBloc(GetRecordsUseCase(RecordRepository(GetRemotRecord())))
                ..add(FetchRecords()),
        ),
        BlocProvider(
          create: (context) => ValueRecordBloc(
            SendValueRecordUseCase(
              ValueRecordRepositoryImpl(RemotValue()),
            ),
          ),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.34.h,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              image: DecorationImage(
                image: AssetImage("assets/images/cute.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
            
          BlocBuilder<RecordBloc, RecordState>(
            builder: (context, state) {
              if (state is RecordLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is RecordLoaded) {
                if (state.records.isEmpty) {
                  return Center(
                    child: const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text("لا يوجد تسجيلات صوتية"),
                    ),
                  );
                }
            
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.records.length,
                  itemBuilder: (context, index) {
                    return CardRecord(
                      id: state.records[index].id.toString(),
                      name: state.records[index].studentaudio.first_name +
                          state.records[index].studentaudio.last_name,
                      path: ApiManager.baseUrl + state.records[index].file,
                      from_aya: state.records[index].from_ayah_id,
                      to_aya: state.records[index].to_ayah_id,
                      suraname: state.records[index].sura_record.name,
                    );
                  },
                );
              } else if (state is RecordError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text("خطأ: ${state.message}"),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}

class CardRecord extends StatefulWidget {
  final String id;
  final String name;
  final String path;
  final num from_aya;
  final num to_aya;
  final String suraname;

  CardRecord({
    Key? key,
    required this.id,
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
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        //  splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
       child: 
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
              //  spreadRadius: 2,
                blurRadius: 8,
                // offset: const Offset(0, 1),
              ),
            ],
          ),
          child: ExpansionTile(
            title: Text(widget.name),
            expandedAlignment: Alignment.centerLeft,
            childrenPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            children: [
            
              Row(
                children: [
                  IconButton(
                    onPressed: () async{
                       await player.play(UrlSource(widget.path));
                  
                    //  player.resume();
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
          
              const Divider(color: Colors.grey),
          
            
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Text(
                  " ${widget.suraname} سورة من آية ${widget.from_aya} إلى ${widget.to_aya} ",
                  style: const TextStyle(fontSize: 10),
                  textAlign: TextAlign.right,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          
              const Divider(color: Colors.grey),
          
            
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    const Text("تقييم"),
                    const SizedBox(width: 10),
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
                    
                  
                      starOffColor: const Color(0xffe7e8ea),
                      starColor: Colors.yellow,
                    ),
                  ],
                ),
              ),
          
              const Divider(color: Colors.grey),
          
              
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextFormField(
                  controller: _commentController,
                  decoration: InputDecoration(
                    hintText: "ارسال ملاحظات",
                    hintStyle: TextStyle(fontSize: 12, color: gray),
                  ),
                ),
              ),
          
            
              BlocConsumer<ValueRecordBloc, ValueRecordState>(
                listener: (context, state) {
                  if (state is ValueRecordSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("تم إرسال التقييم بنجاح "),
                        backgroundColor: Colors.green,
                      ),
                    );
                    _commentController.clear();
                    setState(() => value = 0);
                  } else if (state is ValueRecordFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("فشل الإرسال: ${state.message}"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is ValueRecordLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ElevatedButton(
                      onPressed: () {
                        final record = ValuRecord(
                          textComment: _commentController.text,
                          rate: value,
                        );
                        context.read<ValueRecordBloc>().add(
                              SendValueRecordEvent(record, widget.id),
                            );
                      },
                      child: const Center(child: Text("ارسال")),
                    ),
                  );
                },
              ),
          
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
