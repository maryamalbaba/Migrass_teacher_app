import 'package:dartz/dartz.dart';
import 'package:teacher/core/error/Error_model.dart';

import 'package:teacher/features/StudenTtasmi3/data/Models/SuraModel.dart';

import 'package:teacher/features/StudenTtasmi3/data/source/local.dart';
import 'package:teacher/features/StudenTtasmi3/data/source/remote.dart';
import 'package:teacher/features/StudenTtasmi3/domain/repository/repository.dart';

import 'package:dartz/dartz.dart';

import 'package:teacher/features/StudenTtasmi3/data/Models/SuraModel.dart';
import 'package:teacher/features/StudenTtasmi3/data/source/local.dart';
import 'package:teacher/features/StudenTtasmi3/data/source/remote.dart';
import 'package:teacher/features/StudenTtasmi3/domain/repository/repository.dart';

class SuraRepositoryImpl implements SuraRepository {
  final GetSuraremote r;
  final SuraLocal local;

  SuraRepositoryImpl({required this.r, required this.local});

  @override
  Future<Either<ErrorModel, List<SuraModel>>> getAllSuras() async {
    try {
      // 1.  نجيب من الكاش
      // final cached = local.getchached_sura();
      // if (cached.isNotEmpty) {
      //   //  عم رجع  الكاش لتحسين الأداء
      //   return Right(cached);
      // }

      // 2. إذا الكاش فاضي → منجرب من الـ API
      final result = await r.remote();
      return result.fold(
        (l) {
          print("error here im remot imp");
          return Left(l);
        },
         //  لا يوجد نت وأول مرة
        (r) {
          //  عم نخزن البيانات محليًا
        //  local.chachingsura(r);
          return Right(r);
        },
      );
    } catch (e) {
      return Left(ErrorModel(message: "Unexpected error: $e"));
    }
  }
}
