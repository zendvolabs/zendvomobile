import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginFormState()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
  }

  LoginFormState get _form => state is LoginFormState
      ? state as LoginFormState
      : const LoginFormState();

  void _onEmailChanged(
    LoginEmailChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(_form.copyWith(email: event.email));
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(_form.copyWith(password: event.password));
  }

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (!_form.isFormValid) return;

    final cachedForm = _form;
    emit(LoginLoading());

    try {
      // TODO: Replace with real authentication/repository call
      // Example: await authRepository.login(cachedForm.email, cachedForm.password);
      await Future.delayed(const Duration(seconds: 2));

      // Simulate success - replace with actual user entity
      emit(LoginSuccess('user_entity_placeholder'));
    } catch (e) {
      emit(LoginError(
        e.toString().replaceAll('Exception: ', ''),
      ));
    }
  }
}
