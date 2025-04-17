import 'package:bloc/bloc.dart';

import '../../../../../data/repository/auth_repository.dart';
import '../../../../../di/di.dart';
import '../../../../../utils/response_enum.dart';
import '../../../../../utils/status_enum.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository authRepository = getIt<AuthRepository>();

  RegisterBloc() : super(RegisterState()) {
    on<OnRegisterClick>((event, emit) async {
      emit(state.copyWith(status: Status.loading));
      final ResponseEnum result =
          await authRepository.register(event.userName, event.password);
      switch (result) {
        case ResponseEnum.USER_NOT_FOUND:
          break;
        case ResponseEnum.PASSWORD_MISMATCH:
          break;
        case ResponseEnum.USER_ALREADY_EXIST:
          emit(state.copyWith(status: Status.fail, errorMsg: "User already exist"));
          break;
        case ResponseEnum.USER_FOUND:
          break;
        case ResponseEnum.REGISTER_SUCCESS:
          emit(state.copyWith(status: Status.success, errorMsg: null));
          break;
        case ResponseEnum.UNKNOWN:
          emit(state.copyWith(status: Status.fail, errorMsg: "Unknown error"));
      }
    });
  }
}
