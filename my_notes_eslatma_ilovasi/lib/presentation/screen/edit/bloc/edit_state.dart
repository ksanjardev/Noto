part of 'edit_bloc.dart';

class EditState {
  final Status status;
  final String? errorMsg;
  final bool isEditing;
  EditState({
    this.status = Status.initial,
    this.errorMsg,
    this.isEditing = false,
  });

  EditState copyWith({
    Status? status,
    String? errorMsg,
    bool? isEditing,
  }) {
    return EditState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      isEditing: isEditing ?? this.isEditing,
    );
  }
}
