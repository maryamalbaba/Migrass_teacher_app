// repository/record_repository.dart
import 'package:teacher/core/error/Error_model.dart';
import 'package:teacher/features/records/data/source/remote/get_remot_record.dart';

import '../models/record_model.dart';

import 'package:dartz/dartz.dart';

class RecordRepository {
  final GetRemotRecord remote;

  RecordRepository(this.remote);

  Future<Either<ErrorModel, List<RecordModel>>> getRecords() async {
    return await remote.get_remot_record();
  }
}
