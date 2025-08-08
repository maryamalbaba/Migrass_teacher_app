// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:teacher/core/error/Error_model.dart';
import 'package:teacher/features/tasmi3/data/models/tasmi3_model.dart';
import 'package:teacher/features/tasmi3/domain/repository/repositry_tasmi3group.dart';

class GetAllTasmi3GroupUseCase {
  RepositryTasmi3group repo;
  GetAllTasmi3GroupUseCase({
    required this.repo,
  });
  Future<Either<ErrorModel, List<Tasmi3Model>>> get call  async{
    return repo.getAllgroupTasmi3();
  }
}
