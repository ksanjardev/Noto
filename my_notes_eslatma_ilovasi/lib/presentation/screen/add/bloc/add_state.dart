part of 'add_bloc.dart';

class AddState {
  final Status status;
  final String? errorMsg;
  final bool isEditing;

  AddState({
    this.status = Status.initial,
    this.errorMsg,
    this.isEditing = true,
  });

  AddState copyWith({
    Status? status,
    String? errorMsg,
    bool? isEditing,
  }) {
    return AddState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      isEditing: isEditing ?? this.isEditing,
    );
  }
}
