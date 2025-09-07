// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teacher/features/Student_history/domain/enum/type_tasmi3enum.dart';

import 'package:teacher/features/getbookhadith/data/models/hadith_model.dart';
import 'package:teacher/features/getbookhadith/data/repository/repoImp.dart';
import 'package:teacher/features/getbookhadith/data/source/remote/remote.dart';
import 'package:teacher/features/getbookhadith/domain/usecase/gethadithusecase.dart';
import 'package:teacher/features/getbookhadith/presentation/bloc/hadithbook_bloc.dart';
import 'package:teacher/features/sendtasmi3/create_quran_tasmi3/data/models/hadithtasmi3.dart';
import 'package:teacher/features/sendtasmi3/create_quran_tasmi3/data/models/tasmi_send.dart';
import 'package:teacher/features/sendtasmi3/create_quran_tasmi3/data/repo/repoImp.dart';
import 'package:teacher/features/sendtasmi3/create_quran_tasmi3/data/source/remote/send_remote.dart';
import 'package:teacher/features/sendtasmi3/create_quran_tasmi3/domin/usecase/usecase.dart';
import 'package:teacher/features/sendtasmi3/create_quran_tasmi3/presentation/bloc/send_tasmi3_bloc.dart';

class HadithScreen extends StatefulWidget {
  final num sessionid;
  final num studentid;
  const HadithScreen({
    Key? key,
    required this.sessionid,
    required this.studentid,
  }) : super(key: key);

  @override
  State<HadithScreen> createState() => _HadithScreenState();
}

class _HadithScreenState extends State<HadithScreen> {
  HadithModel? selectedBook;
  int? startHadith;
  int? endHadith;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HadithbookBloc(
            Gethadithusecase(r: hadithRepoImp(r: remotHadith())),
          )..add(FetchHadithEvent()),
        ),
        BlocProvider(
          create: (context) => SendTasmi3Bloc(
            SendTasmi3UseCase(
              repo: Tasmi3RepositoryImpl(
                remote: SendTasmi3Remote(),
              ),
            ),
          ),
        ),
      ],
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: 120,
              color: Colors.transparent,
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
                child: BlocBuilder<HadithbookBloc, HadithbookState>(
                  builder: (context, state) {
                    if (state is HadithLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is HadithError) {
                      return Center(child: Text("خطأ: ${state.message}"));
                    } else if (state is HadithSucces) {
                      final books = state.hadiths;

                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            DropdownButtonFormField<String>(
                              value: selectedBook?.name,
                              hint: const Text("اختر الكتاب"),
                              items: books
                                  .map((book) => DropdownMenuItem(
                                        value: book.name,
                                        child: Text(book.name),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedBook =
                                      books.firstWhere((b) => b.name == value);
                                  startHadith = null;
                                  endHadith = null;
                                });
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 30),

                            // صف من حديث .. إلى حديث (دائمًا ظاهر)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // من حديث
                                Expanded(
                                  child: DropdownButtonFormField<int>(
                                    isExpanded: true,
                                    value: startHadith,
                                    hint: const Text("من حديث"),
                                    items: (selectedBook != null
                                            ? List.generate(
                                                selectedBook!.hadith_num
                                                    .toInt(),
                                                (i) => i + 1,
                                              )
                                            : <int>[])
                                        .map((num) => DropdownMenuItem(
                                              value: num,
                                              child: Text(num.toString()),
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        startHadith = value;
                                        if (endHadith != null &&
                                            endHadith! < startHadith!) {
                                          endHadith = null;
                                        }
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(width: 16),

                                // إلى حديث
                                Expanded(
                                  child: DropdownButtonFormField<int>(
                                    isExpanded: true,
                                    value: endHadith,
                                    hint: const Text("إلى حديث"),
                                    items: (selectedBook != null
                                            ? List.generate(
                                                selectedBook!.hadith_num
                                                    .toInt(),
                                                (i) => i + 1,
                                              ).where((num) =>
                                                startHadith == null ||
                                                num >= startHadith!)
                                            : <int>[])
                                        .map((num) => DropdownMenuItem(
                                              value: num,
                                              child: Text(num.toString()),
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        endHadith = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 40),

                          
                            BlocListener<SendTasmi3Bloc, SendTasmi3State>(
                              listener: (context, state) {
                                if (state is SendTasmi3Success) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("تم الإرسال بنجاح ")),
                                  );
                                } else if (state is SendTasmi3Error) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text("خطأ: ${state.message}")),
                                  );
                                }
                              },
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green.shade600,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                    horizontal: 40,
                                  ),
                                ),
                                onPressed: (selectedBook != null &&
                                        startHadith != null &&
                                        endHadith != null)
                                    ? () {
                                        final hadithModel = Hadithtasmi3(
                                          session_id: widget.sessionid,
                                          student_id: widget.studentid,
                                          book_id: selectedBook!
                                              .id, 
                                          from_hadith: startHadith!,
                                          to_hadith: endHadith!,
                                          is_counted: true,
                                          is_exam: false,
                                          attendance: true,
                                        );

                                        context.read<SendTasmi3Bloc>().add(
                                              SendTasmi3(
                                                type: HalaqaType.hadith,
                                                model: hadithModel 
                                              ),
                                            );
                                      }
                                    : null,
                                child: const Text(
                                  "إرسال",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return const Center(child: Text("جاري التحميل..."));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
