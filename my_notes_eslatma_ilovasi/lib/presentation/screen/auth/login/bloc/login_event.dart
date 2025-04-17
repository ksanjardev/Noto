part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class OnLoginClick extends LoginEvent {
  final String userName;
  final String password;

  OnLoginClick({required this.userName, required this.password});
}
class OnRegisterClick extends LoginEvent{}