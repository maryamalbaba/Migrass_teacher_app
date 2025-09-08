// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teacher/core/resource/navigator_manager.dart';

import 'package:teacher/features/StudenTtasmi3/data/Models/SuraModel.dart';
import 'package:teacher/features/StudenTtasmi3/data/repository/repoImp.dart';
import 'package:teacher/features/StudenTtasmi3/data/source/local.dart';
import 'package:teacher/features/StudenTtasmi3/data/source/remote.dart';
import 'package:teacher/features/StudenTtasmi3/domain/repository/repository.dart';
import 'package:teacher/features/StudenTtasmi3/domain/usecase/usecase_sura.dart';
import 'package:teacher/features/StudenTtasmi3/presentation/bloc/sura_bloc.dart';
import 'package:teacher/features/Student_history/domain/enum/type_tasmi3enum.dart';
import 'package:teacher/features/sendtasmi3/create_quran_tasmi3/data/models/quran_tasmi3_send.dart';
import 'package:teacher/features/sendtasmi3/create_quran_tasmi3/data/models/talqeen_tasmi3_send.dart';
import 'package:teacher/features/sendtasmi3/create_quran_tasmi3/data/repo/repoImp.dart';
import 'package:teacher/features/sendtasmi3/create_quran_tasmi3/data/source/remote/send_remote.dart';
import 'package:teacher/features/sendtasmi3/create_quran_tasmi3/domin/usecase/usecase.dart';
import 'package:teacher/features/sendtasmi3/create_quran_tasmi3/presentation/bloc/send_tasmi3_bloc.dart';

class talqeeentInputUi extends StatefulWidget {
  final num sessionid;
  final num studentid;

  const talqeeentInputUi({
    Key? key,
    required this.sessionid,
    required this.studentid,
  }) : super(key: key);

  @override
  State<talqeeentInputUi> createState() => _talqeeentInputUiState();
}

class _talqeeentInputUiState extends State<talqeeentInputUi> {
  SuraModel? selectedSura1;
  SuraModel? selectedSura2;
  String? selectedAya1;
  String? selectedAya2;
  // bool isExsam = false;
  bool iscounted = false;
  bool isattend = false;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SuraBloc(GetAllSurasUseCase(
              SuraRepositoryImpl(r: GetSuraremote(), local: SuraLocal())))
            ..add(GetsuraEvent()),
        ),
        BlocProvider(
          create: (context) => SendTasmi3Bloc(
            SendTasmi3UseCase(
              repo: Tasmi3RepositoryImpl(remote: SendTasmi3Remote()),
            ),
          ),
        ),
      ],
      child: BlocBuilder<SuraBloc, SuraState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFFD9EAD3),
              leading: IconButton(onPressed: (){
                AppNavigator.instance.pop();
              }, icon: Icon(Icons.arrow_back)),
            ),
            backgroundColor: const Color(0xFFD9EAD3),
            body: SafeArea(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: const BoxDecoration(),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "مقدار التسميع:",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Dropdown للسورة الأولى
                                BlocBuilder<SuraBloc, SuraState>(
                                  builder: (context, state) {
                                    if (state is GetSuraSucess) {
                                      return DropdownButton<SuraModel>(
                                        value: selectedSura1,
                                        items: state.l
                                            .map((sura) => DropdownMenuItem(
                                                  value: sura,
                                                  child: Text(sura.name),
                                                ))
                                            .toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            selectedSura1 = value;
                                            selectedAya1 =
                                                null; // نرجع نفضي الآية عند تغيير السورة
                                          });
                                        },
                                      );
                                    } else {
                                      return const Text("خطأ في السور");
                                    }
                                  },
                                ),
                                const Text("من آية"),
                                // Dropdown لآيات السورة الأولى
                                BlocBuilder<SuraBloc, SuraState>(
                                  builder: (context, state) {
                                    if (state is GetSuraSucess &&
                                        selectedSura1 != null) {
                                      // جيب السورة المختارة
                                       final sura = selectedSura1!;

                                      // اعمل ليست من 1 الى عدد آيات السورة
                                      final ayaList = List.generate(
                                        sura.ayat_counts.toInt(),
                                        (index) => (index + 1).toString(),
                                      );

                                      return DropdownButton<String>(
                                        value: selectedAya1,
                                        items: ayaList
                                            .map((aya) => DropdownMenuItem(
                                                  value: aya,
                                                  child: Text(aya),
                                                ))
                                            .toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            selectedAya1 = value;
                                          });
                                        },
                                      );
                                    } else {
                                      return const Text("اختر سورة ");
                                    }
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Dropdown للسورة الثانية
                                BlocBuilder<SuraBloc, SuraState>(
                                  builder: (context, state) {
                                    if (state is GetSuraSucess) {
                                      return DropdownButton<SuraModel>(
                                        value: selectedSura2,
                                        items: state.l
                                            .map((sura) => DropdownMenuItem(
                                                  value: sura,
                                                  child: Text(sura.name),
                                                ))
                                            .toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            selectedSura2 = value;
                                            selectedAya2 =
                                                null; // نرجع نفضي الآية عند تغيير السورة
                                          });
                                        },
                                      );
                                    } else {
                                      return const Text("خطأ في السور");
                                    }
                                  },
                                ),
                                const Text("إلى آية"),
                                // Dropdown لآيات السورة الثانية
                                BlocBuilder<SuraBloc, SuraState>(
                                  builder: (context, state) {
                                    if (state is GetSuraSucess &&
                                        selectedSura2 != null) {
                                      final sura = selectedSura2!;

                                      final ayaList = List.generate(
                                        sura.ayat_counts.toInt(),
                                        (index) => (index + 1).toString(),
                                      );

                                      return DropdownButton<String>(
                                        value: selectedAya2,
                                        items: ayaList
                                            .map((aya) => DropdownMenuItem(
                                                  value: aya,
                                                  child: Text(aya),
                                                ))
                                            .toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            selectedAya2 = value;
                                          });
                                        },
                                      );
                                    } else {
                                      return const Text(
                                        "اختر سورة ",
                                        overflow: TextOverflow.fade,
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                            const Divider(),
                            // CustumCheckBoxList(
                            //   // iscounted1: isExsam,
                            //   text: 'سبر',
                            // ),
                            CustumCheckBoxList(
                              iscounted1: iscounted,
                              text: 'هل محسوب ام لا',
                            ),
                            CustumCheckBoxList(
                                iscounted1: isattend, text: 'حضور'),
                            const SizedBox(height: 20),
                            BlocListener<SendTasmi3Bloc, SendTasmi3State>(
                              listener: (context, state) {
                                if (state is SendTasmi3Success) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("تم الإرسال بنجاح ")),
                                  );
                                } else if(state is SendTasmi3Loading) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(" يتم الارسال ")),
                                  );
                                }
                                else{
                                   ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(" حصل خطأ ..انتبه على ترتيب السور والايات")),
                                  );
                                }
                              },
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFD9EAD3),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  minimumSize: const Size(double.infinity, 45),
                                ),
                                onPressed: () {
                                  if (selectedSura1 != null &&
                                      selectedAya1 != null &&
                                      selectedSura2 != null &&
                                      selectedAya2 != null) {
                                    final model = TalqeenTasmi3Send(
                                      session_id: widget.sessionid,
                                      student_id: widget.studentid,
                                      from_sura_id: selectedSura1!.id,
                                      from_verse: int.parse(selectedAya1!),
                                      to_sura_id: selectedSura2!
                                          .id, 
                                      to_verse: int.parse(selectedAya2!),
                                     // is_counted: iscounted,
                                    //  is_exam: isExsam,
                                      attendance: isattend,
                                    );

                                    context.read<SendTasmi3Bloc>().add(
                                          SendTasmi3(
                                            type: HalaqaType.talqen,
                                            model: model,
                                          ),
                                        );
                                  }
                                },
                                child: const Text(
                                  "إرسال",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CustumCheckBoxList extends StatefulWidget {
  CustumCheckBoxList({
    Key? key,
    required this.iscounted1,
    required this.text,
  }) : super(key: key);
  bool iscounted1;
  final String text;
  @override
  State<CustumCheckBoxList> createState() => _CustumCheckBoxListState();
}

class _CustumCheckBoxListState extends State<CustumCheckBoxList> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        title: Text(widget.text),
        value: widget.iscounted1!,
        onChanged: (val) {
          setState(() {
            widget.iscounted1 = val!;
          });
        });
  }
}
