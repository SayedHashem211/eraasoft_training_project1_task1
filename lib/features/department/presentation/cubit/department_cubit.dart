import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:task_management_eraa_soft/features/user/presentation/cubit/user_cubit.dart';

import '../../../../core/constants.dart';
import '../../data/models/add_new_department_model.dart';
import '../../data/models/update_department_model.dart';

part 'department_state.dart';

class DepartmentCubit extends Cubit<DepartmentState> {
  DepartmentCubit() : super(DepartmentInitial());


  static DepartmentCubit get(context) => BlocProvider.of(context);

  Future<void> addDepartment(String name) async {
    emit(AddNewDepartmentLoadingState());
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://tasksapp.integration25.com/api/',
        headers: {
          'Content-Type': 'application/json',
          'Authorization' : 'Bearer $token'
        },
      ),
    );

    try {
      final response = await dio.post(
        'department/store',
        data: {
          'name': name,
        },
      );
      AddNewDepartmentModel addNewDepartmentModel = AddNewDepartmentModel.fromJson(response.data);
      emit(AddNewDepartmentSuccessState(addNewDepartmentModel));

    } catch (e) {
      // Handle any errors that may occur
      emit(AddNewDepartmentErrorState('Failed to login: ${e.toString()}'));
      debugPrint('Error during add department: ${e.toString()}');
    }
  }


  Future<void> updateDepartment(String name , String managerID) async {
    emit(UpdateDepartmentLoadingState());
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://tasksapp.integration25.com/api/',
        headers: {
          'Content-Type': 'application/json',
          'Authorization' : 'Bearer $token'
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
        'department/update/$managerID',
        data: {
          'name': name,
          'manager_id' : managerID
        },
      );
      UpdateDepartmentModel updateDepartmentModel = UpdateDepartmentModel.fromJson(response.data);
      emit(UpdateDepartmentSuccessState(updateDepartmentModel));

    } catch (e) {
      // Handle any errors that may occur
      emit(UpdateDepartmentErrorState('Failed to login: ${e.toString()}'));
      debugPrint('Error during update department: ${e.toString()}');
    }
  }
}
