part of 'register_bloc.dart';

class RegisterEvent {}

class OnRegisterClick extends RegisterEvent {
  final String userName;
  final String password;

  OnRegisterClick({required this.userName, required this.password});
}

class OnLoginClick extends RegisterEvent {}
