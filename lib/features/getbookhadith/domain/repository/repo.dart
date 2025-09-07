import 'package:dartz/dartz.dart';
import 'package:teacher/core/error/Error_model.dart';
import 'package:teacher/features/getbookhadith/data/models/hadith_model.dart';

abstract class repository{
Future<Either<ErrorModel,List<HadithModel>>> gethadith();

} 