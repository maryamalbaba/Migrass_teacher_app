// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:teacher/core/resource/navigator_manager.dart';
import 'package:teacher/core/resource/route_const.dart';
import 'package:teacher/core/widgets/studentContainer.dart';
import 'package:teacher/features/showstudent/data/source/remote/remote.dart';
import 'package:teacher/features/showstudent/presentation/bloc/show_students_bloc.dart';
import 'package:teacher/features/tasmi3/data/models/student_model.dart';

class ShowStudentUi extends StatelessWidget {
  final num id;
   final String circleType;
  const ShowStudentUi({
    Key? key,
    required this.id,
    required this.circleType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ShowStudentsBloc(service: ShowCircle())..add(ShowStudentevent(id: id)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('قائمة الطلاب'),
        ),
        body: BlocBuilder<ShowStudentsBloc, ShowStudentsState>(
          builder: (context, state) {
            if (state is LoadingShowStudent) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SucceseShowStudent) {
              return _buildStudentsList(state.list);
            } else if (state is ErrorShowStudent) {
              return const Center(child: Text('حصل خطأ أثناء تحميل الطلاب'));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildStudentsList(List<StudentModel> students) {
    if (students.isEmpty) {
      return const Center(child: Text('لا يوجد طلاب'));
    }
    return ListView.builder(
      itemCount: students.length,
      itemBuilder: (context, index) {
        final student = students[index];
        return
      

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: PlantCard(
            name: student.first_name?? "بدون اسم", 
            
            onView: () { 
            AppNavigator.instance.push(name: RouteConst.StudentHistoryUi ,extra: [
        student.id.toString(),
         circleType, // النوع اللي جبناه من البداية
     ]
 );
           },),
        );
      },


    );
  }
}
