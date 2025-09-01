import 'package:dartz/dartz.dart';
import 'package:teacher/core/api/api_service.dart';
import 'package:teacher/core/config/sharedPreferences_manager.dart';
import 'package:teacher/core/enums/api_method.dart';
import 'package:teacher/core/enums/shared_preferences_keys.dart';
import 'package:teacher/core/error/Error_model.dart';
import 'package:teacher/core/resource/api_manager.dart';
import 'package:teacher/features/get_session/data/models/session.dart';
import 'package:teacher/features/tasmi3/data/models/tasmi3_model.dart';

class LocalSessionDataSource {
  void chachingSession(List<Session> list) {
    List<String> l =
        List.generate(list.length, (index) => list[index].toJson());
    SharedPreferencesManger.instance
        .setList(SharedPreferencesKeys.Tasmi3session, l);
  }

 List<Session> getChachedSession( num id) {
  final chachefModelList = SharedPreferencesManger.instance
      .getList(SharedPreferencesKeys.Tasmi3session);

  if (chachefModelList == null) return [];

 List <Session>chachdeList=chachefModelList
      .map((e) => Session.fromJson(e))
      .toList();
  return chachdeList;
}




  
}
