import 'package:dartz/dartz.dart';
import 'package:teacher/features/exam/data/data_source/exam_data_source.dart';
import 'package:teacher/features/exam/data/model/exam_model.dart';
import 'package:teacher/features/marks/data/model/mark_model.dart';
import '../../domain/repository/base_exam_repository.dart';

class ExamRepository extends BaseExamRepository {
  final BaseExamRemoteDataSource baseExamRemoteDataSource;

  ExamRepository(this.baseExamRemoteDataSource);

  @override
  Future<Either<String?, List<ExamModel>>> getExam(int circleId) async{
    final result = await baseExamRemoteDataSource.getExam(circleId);
    return result.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<String?, dynamic>> createExam( int circleId, ExamModel exam) async{
    final result = await baseExamRemoteDataSource.createExam(circleId,exam);
    return result.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<String?, dynamic>> updateExam(  ExamModel exam) async{
    final result = await baseExamRemoteDataSource.updateExam(exam);
    return result.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<String?, List<MarkModel>>> addMarks(int exam, List<MarkModel> marks) async{
    final result = await baseExamRemoteDataSource.addMarks(exam,marks);
    return result.fold((l) => Left(l), (r) => Right(r));
  }

}
