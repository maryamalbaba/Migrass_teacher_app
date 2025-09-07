// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:teacher/core/error/Error_model.dart';
import 'package:teacher/features/Student_history/domain/enum/type_tasmi3enum.dart';
import 'package:teacher/features/sendtasmi3/create_quran_tasmi3/data/models/hadithtasmi3.dart';
import 'package:teacher/features/sendtasmi3/create_quran_tasmi3/data/models/succes_model.dart';
import 'package:teacher/features/sendtasmi3/create_quran_tasmi3/data/models/tasmi_send.dart';
import 'package:teacher/features/sendtasmi3/create_quran_tasmi3/domin/repo/repo.dart';

class SendTasmi3UseCase {
  final Tasmi3Repository repo;

  SendTasmi3UseCase({required this.repo});

  Future<Either<ErrorModel, SuccesModel>> call({
    required HalaqaType type,
    required TasmiSend model,
  }) {
    return repo.send(type: type, model: model);
  }
}
