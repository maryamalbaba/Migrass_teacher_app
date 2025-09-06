import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teacher/features/getbookhadith/data/repository/repoImp.dart';
import 'package:teacher/features/getbookhadith/data/source/remote/remote.dart';
import 'package:teacher/features/getbookhadith/domain/usecase/gethadithusecase.dart';
import 'package:teacher/features/getbookhadith/presentation/bloc/hadithbook_bloc.dart';
import 'package:teacher/features/getbookhadith/data/models/hadith_model.dart';

class HadithScreen extends StatefulWidget {
  const HadithScreen({super.key});

  @override
  State<HadithScreen> createState() => _HadithScreenState();
}

class _HadithScreenState extends State<HadithScreen> {
  HadithModel? selectedBook;
  int? startHadith;
  int? endHadith;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HadithbookBloc(
        Gethadithusecase(r: hadithRepoImp(r: remotHadith())),
      )..add(FetchHadithEvent()),
      child: Scaffold(
        backgroundColor: const Color(0xFFD9EAD3),
        appBar: AppBar(
          title: const Text("اختيار الأحاديث"),
          backgroundColor: Colors.green.shade700,
        ),
        body: SafeArea(
          child: Column(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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

                              // زر الإرسال
                              ElevatedButton(
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
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "تم اختيار ${selectedBook!.name}, من حديث $startHadith إلى حديث $endHadith",
                                            ),
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
      ),
    );
  }
}
