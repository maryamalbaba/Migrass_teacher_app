// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:teacher/core/error/Error_model.dart';
import 'package:teacher/features/getbookhadith/data/models/hadith_model.dart';
import 'package:teacher/features/getbookhadith/data/source/remote/remote.dart';
import 'package:teacher/features/getbookhadith/domain/repository/repo.dart';

class hadithRepoImp implements repository {
  remotHadith r;
  hadithRepoImp({
    required this.r,
  });
  @override
  Future<Either<ErrorModel, List<HadithModel>>> gethadith()async {
   final result =await r.get_remote_hadith();

  try{
 return result; // result is already Either<ErrorModel, List<HadithModel>>
  }
catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
}
}