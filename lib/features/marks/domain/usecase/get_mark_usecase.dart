import 'package:dartz/dartz.dart';
import 'package:teacher/features/exam/data/model/exam_model.dart';
import 'package:teacher/features/exam/domain/repository/base_exam_repository.dart';
import 'package:teacher/features/marks/domain/repository/base_mark_repository.dart';

import '../../../marks/data/model/mark_model.dart';

class GetMarkUsecase {
  final BaseMarkRepository baseMarkRepository;

  GetMarkUsecase(this.baseMarkRepository);

  Future<Either<String?, List<MarkModel>>> execute(int examId) async {
    return await baseMarkRepository.getMarks(examId);
  }
}

class AddMarksUsecase {
  final BaseMarkRepository baseMarkRepository;

  AddMarksUsecase(this.baseMarkRepository);

  Future<Either<String?, dynamic>> execute(
      int exam, List<MarkModel> marks) async {
    return await baseMarkRepository.addMarks(exam, marks);
  }
}
