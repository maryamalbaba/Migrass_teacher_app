import 'package:dartz/dartz.dart';
import 'package:teacher/core/api/api_service.dart';
import 'package:teacher/core/enums/api_method.dart';
import 'package:teacher/core/error/Error_model.dart';
import 'package:teacher/core/resource/api_manager.dart';
import 'package:teacher/features/Student_history/domain/enum/type_tasmi3enum.dart';
import 'package:teacher/features/sendtasmi3/create_quran_tasmi3/data/models/hadithtasmi3.dart';
import 'package:teacher/features/sendtasmi3/create_quran_tasmi3/data/models/quran_tasmi3_send.dart';
import 'package:teacher/features/sendtasmi3/create_quran_tasmi3/data/models/succes_model.dart';
import 'package:teacher/features/sendtasmi3/create_quran_tasmi3/data/models/tasmi_send.dart';

// class SendHadithRemote {
//   Future<Either<ErrorModel, SuccesModel>> sendremothadith(
//       Hadithtasmi3 t) async {
//     final result = await ApiService.instance.makeRequest(
//         method: ApiMethod.post,
//         endPoint: ApiManager.HadithCreateApi,
//         body: t.toMap());
//     return result.fold((l) {
//       return Left(ErrorModel(message: l.toString()));
//     }, (r) {
//       return Right(SuccesModel());
//     });
//   }
// }
class SendTasmi3Remote {
  Future<Either<ErrorModel, SuccesModel>> send({
    required HalaqaType type,
    required TasmiSend model,
  }) async {
    late String endPoint;

    switch (type) {
      case HalaqaType.quran:
        endPoint = ApiManager.QuranCreateApi;
        break;
      case HalaqaType.hadith:
        endPoint = ApiManager.HadithCreateApi;
        break;
      case HalaqaType.talqen:
        endPoint = ApiManager.TalqeenCreateApi;
        break;
    }

    final result = await ApiService.instance.makeRequest(
      method: ApiMethod.post,
      endPoint: endPoint,
      body: model.toMap(),
    );

    return result.fold(
      (l) => Left(ErrorModel(message: l.toString())),
      (r) => Right(SuccesModel()),
    );
  }
}
