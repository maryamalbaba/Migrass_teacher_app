import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:teacher/core/network/network.dart';
import 'package:teacher/features/get_session/data/repository/Imp_repository.dart';
import 'package:teacher/features/get_session/data/source/local.dart';
import 'package:teacher/features/get_session/data/source/remote.dart';
import 'package:teacher/features/get_session/domain/repository/repository.dart';
import 'package:teacher/features/get_session/domain/usecase/sessiontasmi3.dart';
import 'package:teacher/features/get_session/presenture/bloc/tasmi3_session_bloc.dart';

class SessionUi extends StatefulWidget {
  SessionUi({super.key, required this.id});

   final num id;

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
                return ListTile(
                  title: Text(state.list[index].date),
                  subtitle: Text(state.list[index].description ?? " "),
                );
              });
        } else if (state is GetSessionFailed) {
          print("error in ui");
          return Text("حصل خطأ بالواجهة");
        } else {
          print("else in ui");
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
