import 'package:dartz/dartz.dart';
import 'package:teacher/core/api/api_service.dart';
import 'package:teacher/core/enums/api_method.dart';
import 'package:teacher/core/error/Error_model.dart';
import 'package:teacher/core/resource/api_manager.dart';
import 'package:teacher/features/sendtasmi3/create_quran_tasmi3/data/models/succes_model.dart';
import 'package:teacher/features/value_record/data/models/value_model.dart';

class RemotValue{

  Future<Either<ErrorModel, SuccesModel>>valurecord(ValuRecord model , String id) async {
     final result = await ApiService.instance.makeRequest(
      method: ApiMethod.post,
      endPoint: ApiManager.valuerRcord+id,
      body: model.toMap(),
    );

    return result.fold(
      (l) => Left(ErrorModel(message: l.toString())),
      (r) => Right(SuccesModel()),
    );
  }
}