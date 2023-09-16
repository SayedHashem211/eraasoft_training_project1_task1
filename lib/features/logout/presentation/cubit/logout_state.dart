part of 'logout_cubit.dart';

@immutable
abstract class LogoutState {}

class LogoutInitial extends LogoutState {}


class LogoutLoadingState extends LogoutState{}
class LogoutSuccessState extends LogoutState{
  final LogoutModel logoutModel;
  LogoutSuccessState(this.logoutModel);
}
class LogoutErrorState extends LogoutState{
  final dynamic logoutModel;
  final String error;
  LogoutErrorState([this.logoutModel, this.error = '']);
}