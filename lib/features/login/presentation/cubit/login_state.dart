part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState{}
class LoginSuccessState extends LoginState{
  final LoginModel loginModel;
  LoginSuccessState(this.loginModel);
}
class LoginErrorState extends LoginState{
  final dynamic loginModel;
  final String error;
  LoginErrorState([this.loginModel, this.error = '']);
}

class ChangePasswordVisibilityState extends LoginState{}
