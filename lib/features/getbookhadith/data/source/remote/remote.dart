import 'package:dartz/dartz.dart';
import 'package:teacher/core/api/api_service.dart';
import 'package:teacher/core/enums/api_method.dart';
import 'package:teacher/core/error/Error_model.dart';
import 'package:teacher/core/resource/api_manager.dart';
import 'package:teacher/features/getbookhadith/data/models/hadith_model.dart';

class remotHadith {
  Future<Either<ErrorModel, List<HadithModel>>> get_remote_hadith() async {
    final result = await ApiService.instance
        .makeRequest(method: ApiMethod.get, endPoint: ApiManager.hadithbookApi);
    return result.fold((l) {
      return Left(ErrorModel(message: l ?? " ops Error happen "));
    }, (r) {
      List<HadithModel> list = List.generate(
          r["data"].length, (index) => HadithModel.fromMap(r["data"][index]));
      return Right(list);
    });
  }
}
