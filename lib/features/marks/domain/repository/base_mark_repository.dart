import 'package:dartz/dartz.dart';
import 'package:teacher/features/session_lesson/data/model/session_model.dart';

import '../../../marks/data/model/mark_model.dart';

abstract class BaseMarkRepository {
  Future<Either<String?, List<MarkModel>>> getMarks(int examId);

  Future<Either<String?, dynamic>> addMarks( int exam,List<MarkModel> marks);

}
