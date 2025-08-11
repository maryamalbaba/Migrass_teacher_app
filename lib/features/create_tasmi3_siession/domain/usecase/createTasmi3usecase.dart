// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:teacher/core/error/Error_model.dart';
import 'package:teacher/features/create_tasmi3_siession/data/model/circleSession.dart';
import 'package:teacher/features/create_tasmi3_siession/data/model/session.dart';
import 'package:teacher/features/create_tasmi3_siession/data/repository/repo_impl.dart';
import 'package:teacher/features/create_tasmi3_siession/domain/repository/create_tasmi3_repository.dart';

class CreateTasmi3Usecase {

repo_createtasmi3 repo;
  CreateTasmi3Usecase({
    required this.repo,
  });

  Future<Either<ErrorModel,CircleSession>> get call async{
    return repo.CreateTasmi3session(Tasmi3Session);
  }

   Future<Either<ErrorModel,CircleSession>> execute(Tasmi3Session session) async {
    return repo.CreateTasmi3session(session);
  }
}


