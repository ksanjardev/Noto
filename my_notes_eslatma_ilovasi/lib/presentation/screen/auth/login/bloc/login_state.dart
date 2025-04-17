part of 'login_bloc.dart';

class LoginState {
  final Status status;
  final String? errorMsg;

  LoginState({this.status = Status.initial, this.errorMsg});

  LoginState copyWith({
    Status? status,
    String? errorMsg,
  }) {
    return LoginState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}
