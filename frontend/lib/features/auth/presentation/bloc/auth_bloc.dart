import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/features/auth/data/models/error_model.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../../domain/usecases/auth_usecase.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCase loginUseCase;

  AuthBloc({required this.loginUseCase}) : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await loginUseCase.doLogin(event.login, event.password);
        emit(AuthSuccess(user: user));
      } catch (e) {
        emit(AuthFailure(error: ErrorModel(error: e.toString())));
        // emit(AuthSuccess(user: User));
      }
    });

    on<RegisterRequest>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await loginUseCase.doRegister(
            event.login, event.password, event.isAdmin);
        emit(AuthSuccess(user: user));
      } catch (e) {
        emit(AuthFailure(error: ErrorModel(error: e.toString())));
      }
    });

/*
    on<ShowRegisterForm>((event, emit)  {
      emit(RegisterFormState());
    });
*/
  }
}
