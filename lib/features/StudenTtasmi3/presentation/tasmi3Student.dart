// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:teacher/features/StudenTtasmi3/data/repository/repoImp.dart';
import 'package:teacher/features/StudenTtasmi3/data/source/local.dart';
import 'package:teacher/features/StudenTtasmi3/data/source/remote.dart';
import 'package:teacher/features/StudenTtasmi3/domain/repository/repository.dart';
import 'package:teacher/features/StudenTtasmi3/domain/usecase/usecase_sura.dart';
import 'package:teacher/features/StudenTtasmi3/presentation/bloc/sura_bloc.dart';

class Tasmi3StudentInputUi extends StatefulWidget {
  const Tasmi3StudentInputUi({super.key});

  @override
  State<Tasmi3StudentInputUi> createState() => _Tasmi3StudentInputUiState();
}

class _Tasmi3StudentInputUiState extends State<Tasmi3StudentInputUi> {
  String? selectedSura1;
  String? selectedSura2;
  String? selectedAya1;
  String? selectedAya2;
bool  isExsam=false ;
bool  iscounted=false;
bool  isattend=false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SuraBloc(GetAllSurasUseCase(
          SuraRepositoryImpl(r: GetSuraremote(), local: SuraLocal())))
        ..add(GetsuraEvent()),
      child: BlocBuilder<SuraBloc, SuraState>(
        builder: (context, state) {
          return Scaffold(
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
                                      return DropdownButton<String>(
                                        value: selectedSura1,
                                        items: state.l
                                            .map((sura) => DropdownMenuItem(
                                                  value: sura.name,
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
                                      final sura = state.l.firstWhere(
                                        (s) => s.name == selectedSura1,
                                      );

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
                                      return DropdownButton<String>(
                                        value: selectedSura2,
                                        items: state.l
                                            .map((sura) => DropdownMenuItem(
                                                  value: sura.name,
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
                                      final sura = state.l.firstWhere(
                                        (s) => s.name == selectedSura2,
                                      );

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
                                      return const Text("اختر سورة ",overflow: TextOverflow.fade,);
                                    }
                                  },
                                ),
                              ],
                            ),
                            const Divider(),
                           CustumCheckBoxList(iscounted1:isExsam , text: 'سبر',),
                            CustumCheckBoxList(iscounted1: iscounted, text: 'هل محسوب ام لا',),
                            CustumCheckBoxList(iscounted1: isattend, text: 'حضور'),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFD9EAD3),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                minimumSize: const Size(double.infinity, 45),
                              ),
                              onPressed: () {},
                              child: const Text(
                                "إرسال",
                                style: TextStyle(color: Colors.black),
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
                              value: widget.iscounted1!, onChanged: (val) {
                              setState(() {
                               widget.iscounted1=val!;
                              });
                            });
  }
}