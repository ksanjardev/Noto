import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_notes_eslatma_ilovasi/data/model/note_model/notedata.dart';
import 'package:my_notes_eslatma_ilovasi/data/repository/note_repository.dart';
import 'package:my_notes_eslatma_ilovasi/di/di.dart';

import '../../../../utils/status_enum.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final NoteRepository noteRepository = getIt<NoteRepository>();

  HomeBloc() : super(HomeState()) {
    on<GetNotes>((event, emit) async {
      emit(state.copyWith(status: Status.loading));
      emit(state.copyWith(
          status: Status.success, notes: noteRepository.getNotes()));
    });
    on<DeleteNote>((event, emit) async {
      emit(state.copyWith(status: Status.loading));
      final result = await noteRepository.deleteNote(event.noteId);
      emit(state.copyWith(
          status: result ? Status.success : Status.fail,
          errorMsg: result ? null : "Unknown edit note error"));
    });
  }
}
