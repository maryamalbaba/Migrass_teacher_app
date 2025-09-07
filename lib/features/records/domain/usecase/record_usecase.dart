
// domain/usecases/get_records_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:teacher/core/error/Error_model.dart';
import 'package:teacher/features/records/data/repo/recordrepo.dart';
import '../../data/models/record_model.dart';

class GetRecordsUseCase {
  final RecordRepository repository;

  GetRecordsUseCase(this.repository);

  Future<Either<ErrorModel, List<RecordModel>>> call() async {
    return await repository.getRecords();
  }
}
