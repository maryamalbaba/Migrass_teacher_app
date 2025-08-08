import 'package:teacher/core/api/api_service.dart';
import 'package:teacher/core/enums/api_method.dart';
import 'package:teacher/core/error/Error_model.dart';
import 'package:teacher/core/resource/api_manager.dart';
import 'package:teacher/features/tasmi3/data/models/tasmi3_model.dart';

class RemoteTasmi3groupDataSource {
  remotservice()async{
dynamic result = await ApiService.instance.makeRequest(
    method: ApiMethod.get,
    endPoint: ApiManager.getTasmi3Circle4Teacher,
  );

return
result.fold(
  (l){
    print("left in servive remote");
    return ErrorModel(message: l.toString());
  },
  (r){
    print("enter");
 List<Tasmi3Model> list=List.generate(r["data"].length,  (index)=>Tasmi3Model.fromMap(r["data"][index]));
print("pass");
return list;
  }
  
);


}
}
