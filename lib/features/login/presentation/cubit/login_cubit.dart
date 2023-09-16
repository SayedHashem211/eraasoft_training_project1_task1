import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:task_management_eraa_soft/core/networking/local/flutter_secure_storage.dart';

import '../../../../core/constants.dart';
import '../../../../core/networking/local/cache_helper.dart';
import '../../data/models/login_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());



  static LoginCubit get(context) => BlocProvider.of(context);

  Future<void> login(String email, String password) async {
    emit(LoginLoadingState());
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://tasksapp.integration25.com/api/',
        headers: {'Content-Type': 'application/json'},
      ),
    );

    try {
      final response = await dio.post(
        'auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );
      LoginModel loginModel = LoginModel.fromJson(response.data);
      token = loginModel.data?.token ?? '';
      write(token);

     // CacheHelper.saveData(key: 'Token', value: '${loginModel.data?.token}');

      emit(LoginSuccessState(loginModel));

    } catch (e) {
      // Handle any errors that may occur
      emit(LoginErrorState('Failed to login: ${e.toString()}'));
      debugPrint('Error during login: ${e.toString()}');
    }
  }
  IconData suffix= Icons.visibility_outlined;
  bool isPassword=true;
  void changePasswordVisibility(){
    isPassword =!  isPassword;

    suffix=isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());

  }
}
