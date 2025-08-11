// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:teacher/core/error/Error_model.dart';
import 'package:teacher/features/create_tasmi3_siession/data/model/circleSession.dart';
import 'package:teacher/features/create_tasmi3_siession/data/model/session.dart';
import 'package:teacher/features/create_tasmi3_siession/data/source/remote/remote_source.dart';
import 'package:teacher/features/create_tasmi3_siession/domain/repository/create_tasmi3_repository.dart';

class RepoImpCreateTasmi3Session implements repo_createtasmi3 {
 // final Tasmi3Session tasmi3session;
  final RemoteSource r;

  RepoImpCreateTasmi3Session({
    // required this.tasmi3session,
    required this.r,
  });

  @override
  Future<Either<ErrorModel, CircleSession>> CreateTasmi3session(Tasmi3Session  ) async {
    try {
      
      return await r.remotservice(Tasmi3Session);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }
}

