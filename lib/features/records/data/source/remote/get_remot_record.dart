import 'package:dartz/dartz.dart';
import 'package:teacher/core/api/api_service.dart';
import 'package:teacher/core/enums/api_method.dart';
import 'package:teacher/core/error/Error_model.dart';
import 'package:teacher/core/resource/api_manager.dart';
import 'package:teacher/features/records/data/models/record_model.dart';

class GetRemotRecord {
  Future<Either<ErrorModel, List<RecordModel>>> get_remot_record() async {
    final result = await ApiService.instance
        .makeRequest(method: ApiMethod.get, endPoint: ApiManager.GetaudiApi);
    return result.fold((l) {
      return Left(ErrorModel(message: l.toString()));
    }, (r) {
      List<RecordModel> list = List.generate(r["Audios"].length,
          (index) => RecordModel.fromMap(r["Audios"][index]));
      return Right(list);
    });
  }
}
