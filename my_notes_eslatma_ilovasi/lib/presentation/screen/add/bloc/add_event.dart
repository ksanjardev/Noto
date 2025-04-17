part of 'add_bloc.dart';

@immutable
sealed class AddEvent {}


class OnAddClick extends AddEvent{
  final String title;
  final String description;

  OnAddClick({required this.title, required this.description});
}

class ToggleEditing extends AddEvent {
  final bool isEditing;

  ToggleEditing(this.isEditing);
}