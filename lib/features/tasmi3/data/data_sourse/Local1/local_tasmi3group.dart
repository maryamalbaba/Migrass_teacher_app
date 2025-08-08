import 'package:dartz/dartz.dart';
import 'package:teacher/core/api/api_service.dart';
import 'package:teacher/core/config/sharedPreferences_manager.dart';
import 'package:teacher/core/enums/api_method.dart';
import 'package:teacher/core/enums/shared_preferences_keys.dart';
import 'package:teacher/core/error/Error_model.dart';
import 'package:teacher/core/resource/api_manager.dart';
import 'package:teacher/features/tasmi3/data/models/tasmi3_model.dart';

class LocalTasmi3groupDataSource {
  void chachingTasmi3Circle(List<Tasmi3Model> list) {
    List<String> l =
        List.generate(list.length, (index) => list[index].toJson());
    SharedPreferencesManger.instance
        .setList(SharedPreferencesKeys.tasmi3Circle, l);
  }

 List<Tasmi3Model> getChachedTasmi3Circle() {
  final chachefModelList = SharedPreferencesManger.instance
      .getList(SharedPreferencesKeys.tasmi3Circle);

  if (chachefModelList == null) return [];

 List <Tasmi3Model>chachdeList=chachefModelList
      .map((e) => Tasmi3Model.fromJson(e))
      .toList();
  return chachdeList;
}




  
}
