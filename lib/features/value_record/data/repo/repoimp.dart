import 'package:dartz/dartz.dart';
import 'package:teacher/features/sendtasmi3/create_quran_tasmi3/data/models/succes_model.dart';
import 'package:teacher/features/value_record/data/models/value_model.dart';
import 'package:teacher/features/value_record/data/source/remote.dart';
import 'package:teacher/features/value_record/domain/repo/repo.dart';
import 'package:teacher/core/error/Error_model.dart';

class ValueRecordRepositoryImpl implements ValueRecordRepository {
  final RemotValue remote;

  ValueRecordRepositoryImpl(this.remote);

  @override
  Future<Either<ErrorModel, SuccesModel>> sendValueRecord(
      ValuRecord model, String id) async {
    return  remote.valurecord(model, id);
  }
}


