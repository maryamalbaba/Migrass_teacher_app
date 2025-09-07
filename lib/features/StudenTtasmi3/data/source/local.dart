import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:teacher/core/config/sharedPreferences_manager.dart';
import 'package:teacher/core/enums/shared_preferences_keys.dart';
import 'package:teacher/features/StudenTtasmi3/data/Models/SuraModel.dart';

class SuraLocal {
//   void chachingsura(List<SuraModel> list) {
//     List<String> l =
//         List.generate(list.length, (index) => list[index].toJson());
//     SharedPreferencesManger.instance.setList(SharedPreferencesKeys.sura, l);
//   }

// List<SuraModel>  getchached_sura() {

//    List<String>? s = SharedPreferencesManger.instance.getList(SharedPreferencesKeys.sura);
//   if (s == null || s.isEmpty) return [];

//  List<SuraModel> l = List.generate(
//     s.length,
//     (index) => SuraModel.fromMap(jsonDecode(s[index])),
//    // jsonDecode بتحول لماب 
//   );
// return  l;
//   }

 /// تخزين السور
  void chachingsura(List<SuraModel> list) {
    final l = list.map((s) => s.toJson()).toList();
    print("✅ saving to cache: $l");
    SharedPreferencesManger.instance.setList(SharedPreferencesKeys.sura, l);
  }

  /// قراءة السور من الكاش
  List<SuraModel> getchached_sura() {
    final s = SharedPreferencesManger.instance.getList(SharedPreferencesKeys.sura);
    if (s == null || s.isEmpty) {
      print("⚠️ no cached suras found");
      return [];
    }

    final l = s.map((e) {
      final sura = SuraModel.fromJson(e);
      print("📥 loaded from cache: $sura");
      return sura;
    }).toList();

    return l;
  }

}

//ثلاث خطوات
// اخدنا السترنغ
//حولناه لماب
// واخير عملناه اوبحكت من ماب 