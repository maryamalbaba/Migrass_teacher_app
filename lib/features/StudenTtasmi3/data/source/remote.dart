import 'package:dartz/dartz.dart';
import 'package:teacher/core/api/api_service.dart';
import 'package:teacher/core/enums/api_method.dart';
import 'package:teacher/core/error/Error_model.dart';
import 'package:teacher/core/resource/api_manager.dart';
import 'package:teacher/features/StudenTtasmi3/data/Models/SuraModel.dart';

class GetSuraremote{

   Future <Either<ErrorModel,List<SuraModel>>>
   remote()async{
final result= await ApiService.instance.makeRequest(method: ApiMethod.get, endPoint: ApiManager.sura);

 return result.fold(
  (l){
    print("error in left");
    return Left(ErrorModel(message: l ?? " unknon error"));
    
     
  },
  (r){ 
   //  List<SuraModel> list=List.generate(r["result"].length,  (index)=>SuraModel.fromMap(r["result"][index]["surah"]));
print("hiiii");
     List<SuraModel> list2 = List.generate(
    r["result"].length,
    (index) {
      final surahMap = r["result"][index]["surah"];
      print("surahMap is $surahMap");
      return SuraModel.fromMap(surahMap);
    },
  );

     print("==========================================");

     print("r is $r");
    return Right(list2)
     ;
  

});
   }
}