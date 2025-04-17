part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}
class GetNotes extends HomeEvent{}
class DeleteNote extends HomeEvent{
  final String noteId;

  DeleteNote({required this.noteId});
}