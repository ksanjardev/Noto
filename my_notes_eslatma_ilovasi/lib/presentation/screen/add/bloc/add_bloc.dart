import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:meta/meta.dart';
import 'package:my_notes_eslatma_ilovasi/data/repository/note_repository.dart';
import 'package:my_notes_eslatma_ilovasi/di/di.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;


import '../../../../utils/status_enum.dart';

part 'add_event.dart';
part 'add_state.dart';

class AddBloc extends Bloc<AddEvent, AddState> {
  final NoteRepository noteRepository = getIt<NoteRepository>();

  AddBloc() : super(AddState()) {
    on<OnAddClick>((event, emit) async {
      emit(state.copyWith(status: Status.loading));
      if (event.title.isEmpty) {
        emit(state.copyWith(
            status: Status.fail, errorMsg: "Title cannot be empty"));
        return;
      }
      try {
        final delta = Delta.fromJson(jsonDecode(event.description));
        final plainText = quill.Document.fromDelta(delta).toPlainText().trim();

        if (plainText.isEmpty) {
          emit(state.copyWith(
              status: Status.fail, errorMsg: "Description cannot be empty"));
          return;
        }
      } catch (e) {
        emit(state.copyWith(
            status: Status.fail, errorMsg: "Invalid description data"));
        return;
      }
      final result =
          await noteRepository.addNote(event.title, event.description);
      emit(state.copyWith(
          status: result ? Status.success : Status.fail,
          errorMsg: result ? null : "Unknown add error"));
    });
    on<ToggleEditing>((event, emit) {
      emit(state.copyWith(isEditing: event.isEditing));
    });
  }
}
