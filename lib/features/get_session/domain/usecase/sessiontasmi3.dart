// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:teacher/core/error/Error_model.dart';
import 'package:teacher/features/get_session/data/models/session.dart';
import 'package:teacher/features/get_session/domain/repository/repository.dart';

class GetAllTasmiSessionUseCase {
  RepositrySession repo;

  GetAllTasmiSessionUseCase({
    required this.repo,
   
  });
  
  Future<Either<ErrorModel, List<Session>>>  call(num id)  async{
    return repo.getAllTasmi3Session( id);
  }
}
