import 'package:dartz/dartz.dart';
import 'package:teacher/core/error/Error_model.dart';
import 'package:teacher/features/sendtasmi3/create_quran_tasmi3/data/models/succes_model.dart';
import 'package:teacher/features/value_record/data/models/value_model.dart';

abstract class ValueRecordRepository {
  Future<Either<ErrorModel, SuccesModel>> sendValueRecord(
      ValuRecord model, String id);
}
