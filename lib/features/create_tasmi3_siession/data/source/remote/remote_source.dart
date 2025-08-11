import 'package:dartz/dartz.dart';
import 'package:teacher/core/api/api_service.dart';
import 'package:teacher/core/enums/api_method.dart';
import 'package:teacher/core/error/Error_model.dart';
import 'package:teacher/core/resource/api_manager.dart';
import 'package:teacher/features/create_tasmi3_siession/data/model/circleSession.dart';
import 'package:teacher/features/create_tasmi3_siession/data/model/session.dart';

class RemoteSource {
  Future<Either<ErrorModel, CircleSession>> remotservice(Tasmi3Session c) async {
    final result = await ApiService.instance.makeRequest(
      method: ApiMethod.post,
      endPoint: ApiManager.createTasmi3Session,
      body: c.toMap(),
    );

    return result.fold(
      (errorMsg) {
        print(" error in  remoteSource: $errorMsg");
        return Left(ErrorModel(message: errorMsg ?? "خطأ غير معروف"));
      },
      (data) {
        print(" succes in  remoteSource: $data");
        final sessionData = CircleSession.fromMap(data["data"]["circle"]);
        return Right(sessionData);
      },
    );
  }
}
