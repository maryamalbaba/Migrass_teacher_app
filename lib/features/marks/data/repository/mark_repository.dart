import 'package:dartz/dartz.dart';
import 'package:teacher/features/marks/data/data_source/mark_data_source.dart';
import 'package:teacher/features/marks/data/model/mark_model.dart';
import 'package:teacher/features/marks/domain/repository/base_mark_repository.dart';

class MarkRepository extends BaseMarkRepository{
  final BaseMarkRemoteDataSource baseMarkRemoteDataSource;

  MarkRepository(this.baseMarkRemoteDataSource, );
  @override
  Future<Either<String?, dynamic>> addMarks(int exam, List<MarkModel> marks)async {
    final result = await baseMarkRemoteDataSource.addMarks(exam,marks);
    return result.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<String?, List<MarkModel>>> getMarks(int examId)async {
    final result = await baseMarkRemoteDataSource.getMarks(examId);
    return result.fold((l) => Left(l), (r) => Right(r));
  }


}