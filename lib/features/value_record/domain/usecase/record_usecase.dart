
import 'package:dartz/dartz.dart';
import 'package:teacher/core/error/Error_model.dart';
import 'package:teacher/features/sendtasmi3/create_quran_tasmi3/data/models/succes_model.dart';
import 'package:teacher/features/value_record/data/models/value_model.dart';
import 'package:teacher/features/value_record/domain/repo/repo.dart';

class SendValueRecordUseCase {
  final ValueRecordRepository repository;

  SendValueRecordUseCase(this.repository);

  Future<Either<ErrorModel, SuccesModel>> call(
      ValuRecord model, String id) async {
    return await repository.sendValueRecord(model, id);
  }
}
