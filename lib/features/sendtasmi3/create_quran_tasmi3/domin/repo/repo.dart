// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:teacher/core/error/Error_model.dart';
import 'package:teacher/features/Student_history/domain/enum/type_tasmi3enum.dart';
import 'package:teacher/features/sendtasmi3/create_quran_tasmi3/data/models/hadithtasmi3.dart';
import 'package:teacher/features/sendtasmi3/create_quran_tasmi3/data/models/succes_model.dart';
import 'package:teacher/features/sendtasmi3/create_quran_tasmi3/data/models/tasmi_send.dart';

// abstract class repsitoryHadith {
// Hadithtasmi3 tasmi3;
//   repsitoryHadith({
//     required this.tasmi3,
//   });
// Future<Either<ErrorModel, SuccesModel>> sendhadith(tasmi3);

//  }

abstract class Tasmi3Repository {
  Future<Either<ErrorModel, SuccesModel>> send({
    required HalaqaType type,
    required TasmiSend model,
  });
}