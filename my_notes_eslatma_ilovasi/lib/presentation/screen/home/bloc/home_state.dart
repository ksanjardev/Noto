part of 'home_bloc.dart';

class HomeState {
  final Status status;
  final String? errorMsg;
  final Stream<List<NoteData>>? notes;

  HomeState({this.status = Status.initial, this.errorMsg, this.notes});

  HomeState copyWith(
      {Status? status, String? errorMsg, Stream<List<NoteData>>? notes}) {
    return HomeState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      notes: notes ?? this.notes,
    );
  }
}
