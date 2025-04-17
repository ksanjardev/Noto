part of 'register_bloc.dart';

class RegisterState {
  final Status status;
  final String? errorMsg;

  RegisterState({this.status = Status.initial, this.errorMsg});

  RegisterState copyWith({
    Status? status,
    String? errorMsg,
  }) {
    return RegisterState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}
