import 'package:dartz/dartz.dart';
import 'package:teacher/features/lessons/data/model/lesson_model.dart';
import 'package:teacher/features/session_lesson/data/model/session_model.dart';

import '../../../../core/api/api_service.dart';
import '../../../../core/enums/api_method.dart';
import '../../../../core/resource/api_manager.dart';

abstract class BaseSessionRemoteDataSource{
 Future<Either<String?, List<SessionModel>>> getSession(int circleId);
 Future<Either<String?, dynamic>> createSession(int circleId,SessionRequestModel session);
}

class SessionDataSource extends BaseSessionRemoteDataSource {
 @override


Future<Either<String?, List<SessionModel>>> getSession(int circleId) async {
  final result = await ApiService.instance.makeRequest(
    method: ApiMethod.get,
    endPoint: ApiManager.session + circleId.toString(),
  );

  return result.fold(
    (l) => Left(l.toString()),
    (r) {
      final sessions = r['data'] ?? r['date']; // جرب الاثنين (حسب الـ API)
      
      if (sessions == null || sessions is! List) {
        return const Right([]); // رجع List فاضية إذا مافي بيانات
      }

      return Right(
        List<SessionModel>.from(
          sessions.map((e) => SessionModel.fromJson(e)),
        ),
      );
    },
  );
}
 @override
 Future<Either<String?, dynamic>> createSession(int circleId,
     SessionRequestModel session) async {
  final result = await ApiService.instance.makeRequest(
   method: ApiMethod.post,
   endPoint: ApiManager.createSession + circleId.toString(),
   body: {
    'title':session.title,
    'date':session.date,
    'description':session.description
   }
  );

  return result.fold(
       (l) => Left(l.toString()),
       (r) =>
       const Right(
           unit
       ),
  );
 }


}
