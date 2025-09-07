// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:teacher/core/error/Error_model.dart';
import 'package:teacher/features/getbookhadith/data/models/hadith_model.dart';
import 'package:teacher/features/getbookhadith/domain/repository/repo.dart';

class Gethadithusecase {
  repository r;
  Gethadithusecase({
    required this.r,
  });
  Future<Either<ErrorModel, List<HadithModel>>> get call  async{
    return r.gethadith();
  }
  
}
