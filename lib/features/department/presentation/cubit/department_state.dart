part of 'department_cubit.dart';

@immutable
abstract class DepartmentState {}

class DepartmentInitial extends DepartmentState {}


class AddNewDepartmentLoadingState extends DepartmentState{}
class AddNewDepartmentSuccessState extends DepartmentState{
  final AddNewDepartmentModel addNewDepartmentModel;
  AddNewDepartmentSuccessState(this.addNewDepartmentModel);
}
class AddNewDepartmentErrorState extends DepartmentState{
  final dynamic AddNewDepartmentModel;
  final String error;
  AddNewDepartmentErrorState([this.AddNewDepartmentModel, this.error = '']);
}


class UpdateDepartmentLoadingState extends DepartmentState{}
class UpdateDepartmentSuccessState extends DepartmentState{
  final UpdateDepartmentModel updateDepartmentModel;
  UpdateDepartmentSuccessState(this.updateDepartmentModel);
}
class UpdateDepartmentErrorState extends DepartmentState {
  final dynamic UpdateDepartmentModel;
  final String error;
  UpdateDepartmentErrorState([this.UpdateDepartmentModel, this.error = '']);
}


