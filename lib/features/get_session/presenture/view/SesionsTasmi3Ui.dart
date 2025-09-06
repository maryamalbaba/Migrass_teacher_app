// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:teacher/core/network/network.dart';
import 'package:teacher/core/resource/navigator_manager.dart';
import 'package:teacher/core/resource/route_const.dart';
import 'package:teacher/features/get_session/data/repository/Imp_repository.dart';
import 'package:teacher/features/get_session/data/source/local.dart';
import 'package:teacher/features/get_session/data/source/remote.dart';
import 'package:teacher/features/get_session/domain/repository/repository.dart';
import 'package:teacher/features/get_session/domain/usecase/sessiontasmi3.dart';
import 'package:teacher/features/get_session/presenture/bloc/tasmi3_session_bloc.dart';
import 'package:teacher/features/showstudent/presentation/view/showStudent.dart';

class SessionUi extends StatefulWidget {
  SessionUi({
    Key? key,
    required this.id,
    required this.circleType,
  }) : super(key: key);

  final num id;
 final String circleType;
  @override
  State<SessionUi> createState() => _Tasmi3SessionUiState();
}

class _Tasmi3SessionUiState extends State<SessionUi> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Tasmi3SessionBloc, Tasmi3SessionState>(
      builder: (context, state) {
        if (state is GetSessionSucces) {
          return ListView.builder(
              itemCount: state.list.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    AppNavigator.instance.push(name: RouteConst.ShowStudentUi ,extra:[state.list[index].circle_id ,widget.circleType ]);
                  },
                  child: ListTile(
                    title: Text(state.list[index].day),
                    subtitle: Text(state.list[index].date),
                  ),
                );
              });
        } else if (state is GetSessionEmpty) {
          return Center(child: Text("لا توجد جلسات بعد"));
        } else if (state is GetSessionFailed) {
          print("error in ui");
          return Center(child: Text("حصل خطأ بالواجهة"));
        } else {
          print("else in ui");
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
