part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class ChangeUserTypeState extends UserState{}

class AddUserLoadingState extends UserState{}
class AddUserSuccessState extends UserState{
  final UserModel userModel;
  AddUserSuccessState(this.userModel);
}
class AddUserErrorState extends UserState{
  final dynamic UserModel;
  final String error;
  AddUserErrorState([this.UserModel, this.error = '']);
}



class UpdateUserLoadingState extends UserState{}
class UpdateUserSuccessState extends UserState{
  final UpdateUserModel updateUserModel;
  UpdateUserSuccessState(this.updateUserModel);
}
class UpdateUserErrorState extends UserState{
  final dynamic UpdateUserModel;
  final String error;
  UpdateUserErrorState([this.UpdateUserModel, this.error = '']);
}



