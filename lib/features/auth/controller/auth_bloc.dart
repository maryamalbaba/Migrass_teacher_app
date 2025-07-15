import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teacher/core/api/api_service.dart';
import 'package:teacher/core/config/sharedPreferences_manager.dart';
import 'package:teacher/core/enums/api_method.dart';
import 'package:teacher/core/enums/controller_status.dart';
import 'package:teacher/core/enums/shared_preferences_keys.dart';
import 'package:teacher/core/resource/api_manager.dart';
import 'package:teacher/features/auth/controller/auth_event.dart';
import 'package:teacher/features/auth/controller/auth_state.dart';

import '../model/user_model.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState()) {
    on<LoginEvent>((event, emit) async {
      emit(state.copyWith(
        loginStatus: ControllerStatus.loading,
        myCode: event.myCode,
        mosqueCode: event.mosqueCode,
      ));

      final result = await ApiService.instance.makeRequest(
        method: ApiMethod.post,
        endPoint: ApiManager.login,
        body: {
          'code_user': event.myCode,
          'mosque_code': event.mosqueCode,
        },
      );

      result.fold(
            (l) {
          emit(state.copyWith(
            loginStatus: ControllerStatus.error,
            message: l.toString(),
          ));
        },
            (r) {
          UserModel userModel = UserModel.fromJson(r);
          print(userModel);
          SharedPreferencesManger.instance.setString(
              SharedPreferencesKeys.token, userModel.token);
          SharedPreferencesManger.instance.setString(
              SharedPreferencesKeys.email, userModel.email);
          SharedPreferencesManger.instance.setString(
              SharedPreferencesKeys.firstName, userModel.firstName);
          SharedPreferencesManger.instance.setString(
              SharedPreferencesKeys.lastName, userModel.lastName);
          SharedPreferencesManger.instance.setInt(
              SharedPreferencesKeys.mosqueId, userModel.mosqueId);
          SharedPreferencesManger.instance.setString(
              SharedPreferencesKeys.codeUser, userModel.codeUser);
          SharedPreferencesManger.instance.setString(
              SharedPreferencesKeys.phoneNumber, userModel.phone);
          emit(state.copyWith(
            loginStatus: ControllerStatus.loaded,
          ));
        },
      );
    });
  }
}