import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_notes_eslatma_ilovasi/data/repository/auth_repository.dart';
import 'package:my_notes_eslatma_ilovasi/di/di.dart';
import 'package:my_notes_eslatma_ilovasi/utils/response_enum.dart';
import 'package:my_notes_eslatma_ilovasi/utils/status_enum.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository = getIt<AuthRepository>();

  LoginBloc() : super(LoginState()) {
    on<OnLoginClick>((event, emit) async {
      emit(state.copyWith(status: Status.loading));
      final ResponseEnum result =
          await authRepository.login(event.userName, event.password);
      switch (result) {
        case ResponseEnum.USER_NOT_FOUND:
          emit(state.copyWith(status: Status.fail, errorMsg: "User not found"));
          break;
        case ResponseEnum.PASSWORD_MISMATCH:
          emit(state.copyWith(
              status: Status.fail, errorMsg: "Password mismatch"));
          break;
        case ResponseEnum.USER_ALREADY_EXIST:
          break;
        case ResponseEnum.USER_FOUND:
          emit(state.copyWith(status: Status.success, errorMsg: null));
        case ResponseEnum.REGISTER_SUCCESS:
          break;
        case ResponseEnum.UNKNOWN:
          emit(state.copyWith(status: Status.fail, errorMsg: "Unknown error"));
      }
    });
  }
}
