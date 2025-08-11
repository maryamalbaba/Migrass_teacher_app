import 'package:dartz/dartz.dart';
import 'package:teacher/core/error/Error_model.dart';
import 'package:teacher/features/create_tasmi3_siession/data/model/circleSession.dart';
import 'package:teacher/features/create_tasmi3_siession/presentation/bloc/create_tasmi3_session_bloc.dart';

 abstract class repo_createtasmi3{

  // ignore: non_constant_identifier_names
  Future <Either<ErrorModel,CircleSession>>   CreateTasmi3session(Tasmi3Session  );
}