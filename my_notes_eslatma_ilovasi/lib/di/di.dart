import 'package:get_it/get_it.dart';
import 'package:my_notes_eslatma_ilovasi/data/repository/auth_repository.dart';
import 'package:my_notes_eslatma_ilovasi/data/repository/impl/auth_repository_impl.dart';
import 'package:my_notes_eslatma_ilovasi/data/repository/impl/note_repository_impl.dart';
import 'package:my_notes_eslatma_ilovasi/data/repository/note_repository.dart';

final getIt = GetIt.instance;

void setUp() {
  getIt.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  getIt.registerSingleton<NoteRepository>(NoteRepositoryImpl());
}
