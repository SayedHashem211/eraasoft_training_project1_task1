import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/constants.dart';
import '../../data/models/logout_model.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit() : super(LogoutInitial());


  static LogoutCubit get(context) => BlocProvider.of(context);

  Future<void> logout() async {
  emit(LogoutLoadingState());
  final dio = Dio(
  BaseOptions(
  baseUrl: 'https://tasksapp.integration25.com/api/',
  headers: {
    'Content-Type': 'application/json',
    'Authorization' : 'Bearer $token',
  },
  ),
  );

  try {
  final response = await dio.post(
  'auth/logout',
  );
  LogoutModel loginModel = LogoutModel.fromJson(response.data);

  // CacheHelper.saveData(key: 'Token', value: '${loginModel.data?.token}');

  emit(LogoutSuccessState(loginModel));

  } catch (e) {
  // Handle any errors that may occur
  emit(LogoutErrorState('Failed to logout: ${e.toString()}'));
  debugPrint('Error during logout: ${e.toString()}');
  }
  }


}
