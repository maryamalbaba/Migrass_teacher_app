// import 'package:equatable/equatable.dart';
// import 'package:teacher/core/enums/controller_status.dart';
//
// class AuthState extends Equatable {
//   final ControllerStatus loginStatus;
//   final String message;
//   final String myCode;
//   final String mosqueCode;
//
//   AuthState({
//     this.loginStatus = ControllerStatus.initial,
//     this.message = '',
//     this.myCode = '',
//     this.mosqueCode = '',
//   });
//
//
//
//   @override
//   // TODO: implement props
//   List<Object?> get props => [message,myCode,mosqueCode,loginStatus];
// }

import 'package:equatable/equatable.dart';
import 'package:teacher/core/enums/controller_status.dart';

class AuthState extends Equatable {
  final ControllerStatus loginStatus;
  final String message;


  AuthState({
    this.loginStatus = ControllerStatus.initial,
    this.message = '',

  });

  AuthState copyWith({
    ControllerStatus? loginStatus,
    String? message,
    String? myCode,
    String? mosqueCode,
  }) {
    return AuthState(
      loginStatus: loginStatus ?? this.loginStatus,
      message: message ?? this.message,

    );
  }

  @override
  List<Object?> get props => [loginStatus, message, ];
}