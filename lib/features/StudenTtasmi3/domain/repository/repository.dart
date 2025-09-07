import 'package:dartz/dartz.dart';
import 'package:teacher/core/error/Error_model.dart';

import 'package:teacher/features/StudenTtasmi3/data/Models/SuraModel.dart';

abstract class SuraRepository {
  Future<Either<ErrorModel, List<SuraModel>>> getAllSuras();
}