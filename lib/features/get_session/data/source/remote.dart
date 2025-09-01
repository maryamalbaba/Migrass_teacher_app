import 'package:teacher/core/api/api_service.dart';
import 'package:teacher/core/enums/api_method.dart';
import 'package:teacher/core/error/Error_model.dart';
import 'package:teacher/core/resource/api_manager.dart';
import 'package:teacher/features/get_session/data/models/session.dart';
import 'package:teacher/features/tasmi3/data/models/tasmi3_model.dart';

class RemoteSessionDataSource {
  remotservice(num id)async{
dynamic result = await ApiService.instance.makeRequest(
    method: ApiMethod.get,
    endPoint: ApiManager.grtTasmmi3SessionforAncircle+id.toString(),

  );

return
result.fold(
  (l){
    print("left in servive session remote");
    print(l.toString());
    return ErrorModel(message: l.toString());
  },
  (r){
    print("enter");
 List<Session> list=List.generate(r["session"].length,  (index)=>Session.fromMap(r["session"][index]));
print("pass");
return list;
  }
  
);


}
}
