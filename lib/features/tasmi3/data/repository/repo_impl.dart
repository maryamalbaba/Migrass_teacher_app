// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:teacher/core/error/Error_model.dart';
import 'package:teacher/core/network/network.dart';
import 'package:teacher/features/tasmi3/data/data_sourse/remote/remote_tasmi3group.dart';
import 'package:teacher/features/tasmi3/data/data_sourse/Local1/local_tasmi3group.dart';
import 'package:teacher/features/tasmi3/data/models/tasmi3_model.dart';
import 'package:teacher/features/tasmi3/domain/repository/repositry_tasmi3group.dart';

// class Tasmi3groupRepoImpl implements RepositryTasmi3group {
//   RemoteTasmi3groupDataSource remoteTasmi3groupDataSource;
//   LocalTasmi3groupDataSource locaTasmi3groupDataSource;
//   NetworkConnection2 networkConnection;
//   Tasmi3groupRepoImpl(
//       {required this.locaTasmi3groupDataSource,
//       required this.networkConnection,
//       required this.remoteTasmi3groupDataSource});

//   @override
//   Future<Either<ErrorModel, List<Tasmi3Model>>> getAllgroupTasmi3() async {
//     print('==========================================================');
   
//     if (await networkConnection.is_connected) {
//       try {
//    final groups =
//             await remoteTasmi3groupDataSource.remotservice();
//         if (groups is List<Tasmi3Model>) {
//         // List<Tasmi3Model> groups1 = await remoteTasmi3groupDataSource.remotservice();
//           locaTasmi3groupDataSource.chachingTasmi3Circle(groups);

//           print("pass repo Im");
//           return Right(groups);


//         } 
        
//         else {
//           return left(ErrorModel(message: "حصل خطا ما بطبقة الانترنت"));
//         }


//       } on Exception {
//         print(" Error on repoIm");
//         return Left(ErrorModel(message: 'حصل خطأ'));
//       }
//     } else {
//       try {
//         List<Tasmi3Model> chachedgroup =
//             await locaTasmi3groupDataSource.getChachedTasmi3Circle();
//         return Right(chachedgroup);
//       } on Exception {
//         print("Exception:: $Exception");
//         return Left(
//           ErrorModel(message: "لا يوجد غروبات"),
//         );
//       }
//     }
//   }
// }


class Tasmi3groupRepoImpl implements RepositryTasmi3group {
  final RemoteTasmi3groupDataSource remoteTasmi3groupDataSource;
  final LocalTasmi3groupDataSource locaTasmi3groupDataSource;
  final NetworkMonitor networkMonitor;

  Tasmi3groupRepoImpl({
    required this.locaTasmi3groupDataSource,
    required this.networkMonitor,
    required this.remoteTasmi3groupDataSource,
  });

  @override
  Future<Either<ErrorModel, List<Tasmi3Model>>> getAllgroupTasmi3() async {
    print('==========================================================');

    try {
      if (await networkMonitor.isConnected) {
        // عندي نت → جرب من الريموت
        final groups = await remoteTasmi3groupDataSource.remotservice();

        if (groups is List<Tasmi3Model>) {
          locaTasmi3groupDataSource.chachingTasmi3Circle(groups);
          print("✅ pass repo Impl (remote)");
          return Right(groups);
        } else {
          return Left(ErrorModel(message: "حصل خطأ ما بطبقة الانترنت"));
        }
      } else {
        // ما في نت → رجع الكاش
        final chachedgroup = locaTasmi3groupDataSource.getChachedTasmi3Circle();
        if (chachedgroup.isNotEmpty) {
          print("📂 رجع الكاش");
          return Right(chachedgroup);
        } else {
          return Left(ErrorModel(message: "لا يوجد غروبات بالكاش"));
        }
      }
    } catch (e) {
      print("❌ Exception on repoImpl: $e");

      // fallback على الكاش إذا صار Exception مثل DioError
      final chachedgroup = locaTasmi3groupDataSource.getChachedTasmi3Circle();
      if (chachedgroup.isNotEmpty) {
        print("📂 رجع الكاش بعد الخطأ");
        return Right(chachedgroup);
      }

      return Left(ErrorModel(message: "حدث خطأ غير متوقع"));
    }
  }
}
