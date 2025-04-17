part of 'edit_bloc.dart';

@immutable
sealed class EditEvent {}

class OnUpdateClick extends EditEvent{
  final NoteData data;

  OnUpdateClick({required this.data});
}
class ToggleEditing extends EditEvent {
  final bool isEditing;

  ToggleEditing(this.isEditing);
}