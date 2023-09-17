import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/constants.dart';
import '../../data/models/add_user_model.dart';
import '../../data/models/update_user_model.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  int buttonValueUpdate = 0;



  changeUpdateUserValue(value) {
    if (value == "Admin") {
      buttonValueUpdate = 0;
    } else if (value == "Manager") {
      buttonValueUpdate = 1;
    } else if (value == "User") {
      buttonValueUpdate = 2;
    }
    emit(ChangeUserTypeState());
  }

  static UserCubit get(context) => BlocProvider.of(context);

  Future<void> addUser(String name, String email, String password, String phone,
      String departmentID, String userType) async {
    emit(AddUserLoadingState());
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://tasksapp.integration25.com/api/',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        validateStatus: (statusCode){
          if(statusCode == null){
            return false;
          }
          if(statusCode == 422){ // your http status code
            return true;
          }else{
            return statusCode >= 200 && statusCode < 300;
          }
        },
      ),
    );

    try {
      final response = await dio.post(
        'user/store',
        data: {
          'name': name,
          'email': email,
          'phone': phone,
          'password': password,
          'user_type': userType,
          'department_id': departmentID,
        },
      );
      UserModel userModel = UserModel.fromJson(response.data);
      emit(AddUserSuccessState(userModel));
    } catch (e) {
      // Handle any errors that may occur
      emit(AddUserErrorState('Failed to login: ${e.toString()}'));
      debugPrint('Error during add user: ${e.toString()}');
    }
  }



  Future<void> updateUser(String name, String email, String password, String phone,
  String userType, String userStatus,
      String departmentID, ) async {
    emit(UpdateUserLoadingState());
    UserModel? userModel;
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://tasksapp.integration25.com/api/',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      ),
    );

    try {
      final response = await dio.post(
        'user/update/${userModel?.data?.id }',
        data: {
          'name': name,
          'email': email,
          'phone': phone,
          'password': password,
          'user_type': userType,
          'user_status' : userStatus,
          'department_id': departmentID,
        },
      );
      UpdateUserModel updateUserModel = UpdateUserModel.fromJson(response.data);
      emit(UpdateUserSuccessState(updateUserModel));
    } catch (e) {
      // Handle any errors that may occur
      emit(UpdateUserErrorState('Failed to login: ${e.toString()}'));
      debugPrint('Error during update user: ${e.toString()}');
    }
  }
}
