import 'package:teacher/core/api/api_service.dart';
import 'package:teacher/core/enums/api_method.dart';
import 'package:teacher/core/error/Error_model.dart';
import 'package:teacher/core/resource/api_manager.dart';
import 'package:teacher/features/tasmi3/data/models/student_model.dart';

class ShowCircle{

 remotservice( num id)async{
dynamic result = await ApiService.instance.makeRequest(
    method: ApiMethod.get,
    endPoint: ApiManager.ShowStudet+id.toString(),

  );

return
result.fold(
  (l){
    print("left in servive remote");
    return ErrorModel(message: l.toString());
  },
  (r){
    print("enter");
 List<StudentModel> list=List.generate(r["students"].length,  (index)=>StudentModel.fromMap(r["students"][index]));
print("pass");
return list;
  }
  
);


}
}