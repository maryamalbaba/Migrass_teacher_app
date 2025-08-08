import 'package:dartz/dartz.dart';
import 'package:teacher/core/error/Error_model.dart';
import 'package:teacher/features/tasmi3/data/models/tasmi3_model.dart';

abstract class RepositryTasmi3group {
 
  Future<Either<ErrorModel, List<Tasmi3Model>>> getAllgroupTasmi3();
}