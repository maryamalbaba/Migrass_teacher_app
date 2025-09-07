import 'package:dartz/dartz.dart';
import 'package:teacher/core/error/Error_model.dart';

import 'package:teacher/features/StudenTtasmi3/data/Models/SuraModel.dart';
import 'package:teacher/features/StudenTtasmi3/domain/repository/repository.dart';


class GetAllSurasUseCase {
  final SuraRepository repository;

  GetAllSurasUseCase(this.repository);

  Future<Either<ErrorModel, List<SuraModel>>> call() async {
    return await repository.getAllSuras();
  }
}
