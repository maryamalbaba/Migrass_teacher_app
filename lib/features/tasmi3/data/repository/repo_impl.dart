// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:teacher/core/error/Error_model.dart';
import 'package:teacher/core/network/network.dart';
import 'package:teacher/features/tasmi3/data/data_sourse/remote/remote_tasmi3group.dart';
import 'package:teacher/features/tasmi3/data/data_sourse/Local1/local_tasmi3group.dart';
import 'package:teacher/features/tasmi3/data/models/tasmi3_model.dart';
import 'package:teacher/features/tasmi3/domain/repository/repositry_tasmi3group.dart';

class Tasmi3groupRepoImpl implements RepositryTasmi3group {
  RemoteTasmi3groupDataSource remoteTasmi3groupDataSource;
  LocalTasmi3groupDataSource locaTasmi3groupDataSource;
  NetworkConnection2 networkConnection;
  Tasmi3groupRepoImpl(
      {required this.locaTasmi3groupDataSource,
      required this.networkConnection,
      required this.remoteTasmi3groupDataSource});

  @override
  Future<Either<ErrorModel, List<Tasmi3Model>>> getAllgroupTasmi3() async {
    print('==========================================================');
   
    if (await networkConnection.is_connected) {
      try {
   final groups =
            await remoteTasmi3groupDataSource.remotservice();
        if (groups is List<Tasmi3Model>) {
        // List<Tasmi3Model> groups1 = await remoteTasmi3groupDataSource.remotservice();
          locaTasmi3groupDataSource.chachingTasmi3Circle(groups);

          print("pass repo Im");
          return Right(groups);


        } 
        
        else {
          return left(ErrorModel(message: "حصل خطا ما بطبقة الانترنت"));
        }


      } on Exception {
        print(" Error on repoIm");
        return Left(ErrorModel(message: 'حصل خطأ'));
      }
    } else {
      try {
        List<Tasmi3Model> chachedgroup =
            await locaTasmi3groupDataSource.getChachedTasmi3Circle();
        return Right(chachedgroup);
      } on Exception {
        print("Exception:: $Exception");
        return Left(
          ErrorModel(message: "لا يوجد غروبات"),
        );
      }
    }
  }
}
