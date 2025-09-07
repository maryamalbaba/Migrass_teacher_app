// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:teacher/core/error/Error_model.dart';
import 'package:teacher/core/network/network.dart';
import 'package:teacher/features/get_session/data/models/session.dart';
import 'package:teacher/features/get_session/data/source/local.dart';
import 'package:teacher/features/get_session/data/source/remote.dart';
import 'package:teacher/features/get_session/domain/repository/repository.dart';
import 'package:teacher/features/tasmi3/data/data_sourse/Local1/local_tasmi3group.dart';
import 'package:teacher/features/tasmi3/data/data_sourse/remote/remote_tasmi3group.dart';
import 'package:teacher/features/tasmi3/data/models/tasmi3_model.dart';
import 'package:teacher/features/tasmi3/domain/repository/repositry_tasmi3group.dart';

class SessionRepoImpl implements RepositrySession {
  RemoteSessionDataSource remoteSessionDataSource;
  LocalSessionDataSource localSessionDataSource;
//  num  id;
  NetworkConnection2 networkConnection;
  SessionRepoImpl({
    required this.remoteSessionDataSource,
    required this.localSessionDataSource,
   // required this.id,
    required this.networkConnection,
  });
 
 

  @override
  Future<Either<ErrorModel, List<Session>>> getAllTasmi3Session(  num id) async {
    print('==========================================================');
   
    if (await networkConnection.is_connected) {
      try {
   final groups =
            await remoteSessionDataSource.remotservice(id);
        if (groups is List<Session>) {
        // List<Session> groups1 = await remoteSessionDataSource.remotservice(id);
          localSessionDataSource.chachingSession(groups);

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
        List<Session> chachedgroup =
            await localSessionDataSource.getChachedSession( id);
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
