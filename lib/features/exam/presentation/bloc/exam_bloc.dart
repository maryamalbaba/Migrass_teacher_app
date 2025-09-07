//
//
// import 'package:dartz/dartz.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:teacher/core/error/Error_model.dart';
// import 'package:teacher/features/exam/data/model/exam_model.dart';
// import 'package:teacher/features/exam/domain/usecases/add_exam_usecase.dart';
// import 'package:teacher/features/exam/domain/usecases/get_exam_usecase.dart';
// import 'package:teacher/features/exam/domain/usecases/update_exam_usecase.dart';
// import 'package:teacher/features/exam/presentation/bloc/exam_event.dart';
// import 'package:teacher/features/exam/presentation/bloc/exam_state.dart';
//
// class ExamBloc extends Bloc<ExamEvent, ExamState> {
//   final GetExamUsecase getExamUsecase;
//   final AddExamUsecase addExamUsecase;
//   final UpdateExamUsecase updateExamUsecase;
//
//   ExamBloc(this.getExamUsecase, this.addExamUsecase, this.updateExamUsecase)
//       : super(ExamInitial()) {
//     on<FetchExams>((event, emit) async {
//       emit(ExamLoading());
//       final result = await getExamUsecase.execute(event.circleId);
//       emit(result.fold(
//             (error) => ExamError(error: ErrorModel(message: error.toString())),
//             (exams) => ExamSuccess(exams: exams),
//       ));
//     });
//
//     on<CreateExam>((event, emit) async {
//       emit(ExamLoading());
//       final result = await addExamUsecase.execute(event.circleId, event.exam);
//       await result.fold(
//             (error) async => emit(ExamError(error: ErrorModel(message: error.toString()))),
//             (success) async {
//           // Fetch updated exam list after successful creation
//           final examsResult = await getExamUsecase.execute(event.circleId);
//           emit(examsResult.fold(
//                 (error) => ExamError(error: ErrorModel(message: error.toString())),
//                 (exams) => ExamSuccess(exams: exams),
//           ));
//         },
//       );
//     });
//
//     on<UpdateExam>((event, emit) async {


import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:teacher/core/error/Error_model.dart';
import 'package:teacher/features/exam/data/model/exam_model.dart';
import 'package:teacher/features/exam/data/model/mark_model.dart';
import 'package:teacher/features/exam/domain/usecases/add_exam_usecase.dart';
import 'package:teacher/features/exam/domain/usecases/get_exam_usecase.dart';
import 'package:teacher/features/exam/domain/usecases/update_exam_usecase.dart';
import 'package:teacher/features/exam/domain/usecases/add_marks_usecase.dart'; // NEW
import 'package:teacher/features/exam/presentation/bloc/exam_event.dart';
import 'package:teacher/features/exam/presentation/bloc/exam_state.dart';

class ExamBloc extends Bloc<ExamEvent, ExamState> {
  final GetExamUsecase getExamUsecase;
  final AddExamUsecase addExamUsecase;
  final UpdateExamUsecase updateExamUsecase;
  final AddMarksUsecase addMarksUsecase; // NEW

  ExamBloc(
      this.getExamUsecase,
      this.addExamUsecase,
      this.updateExamUsecase,
      this.addMarksUsecase, // NEW
      ) : super(ExamInitial()) {
    on<FetchExams>((event, emit) async {
      emit(ExamLoading());
      final result = await getExamUsecase.execute(event.circleId);
      emit(result.fold(
            (error) => ExamError(error: ErrorModel(message: error.toString())),
            (exams) => ExamSuccess(exams: exams),
      ));
    });

    on<CreateExam>((event, emit) async {
      emit(ExamLoading());
      final result = await addExamUsecase.execute(event.circleId, event.exam);
      await result.fold(
            (error) async => emit(ExamError(error: ErrorModel(message: error.toString()))),
            (success) async {
          final examsResult = await getExamUsecase.execute(event.circleId);
          emit(examsResult.fold(
                (error) => ExamError(error: ErrorModel(message: error.toString())),
                (exams) => ExamSuccess(exams: exams),
          ));
        },
      );
    });

    on<UpdateExam>((event, emit) async {
      emit(ExamLoading());
      final result = await updateExamUsecase.execute(event.exam);
      await result.fold(
            (error) async => emit(ExamError(error: ErrorModel(message: error.toString()))),
            (success) async {
          final examsResult = await getExamUsecase.execute(event.exam.circleId);
          emit(examsResult.fold(
                (error) => ExamError(error: ErrorModel(message: error.toString())),
                (exams) => ExamSuccess(exams: exams),
          ));
        },
      );
    });

    /// NEW: معالجة إضافة العلامات
    on<AddMarks>((event, emit) async {
      emit(AddMarksLoading());
      final result = await addMarksUsecase.execute(event.examId, event.marks);
      emit(result.fold(
            (error) => AddMarksError(error: ErrorModel(message: error.toString())),
            (saved) => AddMarksSuccess(savedMarks: saved),
      ));

      // (اختياري) بعد الحفظ، بإمكانك إعادة إظهار قائمة الامتحانات
      // عبر إعادة جلبها إن رغبت:
      // final examsResult = await getExamUsecase.execute(<circleId>);
      // emit(examsResult.fold(
      //   (error) => ExamError(error: ErrorModel(message: error.toString())),
      //   (exams) => ExamSuccess(exams: exams),
      // ));
    });
  }
}
