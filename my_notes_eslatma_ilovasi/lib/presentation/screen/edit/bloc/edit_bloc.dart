import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_quill/quill_delta.dart';
import "package:meta/meta.dart";
import 'package:my_notes_eslatma_ilovasi/data/model/note_model/notedata.dart';
import 'package:my_notes_eslatma_ilovasi/data/repository/note_repository.dart';
import 'package:my_notes_eslatma_ilovasi/di/di.dart';

import '../../../../utils/status_enum.dart';

part 'edit_event.dart';
part 'edit_state.dart';

class EditBloc extends Bloc<EditEvent, EditState> {
  final NoteRepository noteRepository = getIt<NoteRepository>();

  EditBloc() : super(EditState()) {
    on<OnUpdateClick>((event, emit) async {
      emit(state.copyWith(status: Status.loading));
      if (event.data.title.isEmpty) {
        emit(state.copyWith(
            status: Status.fail, errorMsg: "Title cannot be empty"));
        return;
      }
      try {
        final delta = Delta.fromJson(jsonDecode(event.data.description));
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
      final result = await noteRepository.editNote(event.data);
      emit(state.copyWith(
          status: result ? Status.success : Status.fail,
          errorMsg: result ? null : "Unknown edit note error"));
    });
    on<ToggleEditing>((event, emit) {
      emit(state.copyWith(isEditing: event.isEditing));
    });
  }
}
