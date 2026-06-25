import 'package:flutter_bloc/flutter_bloc.dart';
import 'forgot_password_event.dart';
import 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(const ForgotPasswordFormState()) {
    on<ForgotPasswordEmailChanged>(_onEmailChanged);
    on<ForgotPasswordSubmitted>(_onSubmitted);
  }

  ForgotPasswordFormState get _form => state is ForgotPasswordFormState
      ? state as ForgotPasswordFormState
      : const ForgotPasswordFormState();

  void _onEmailChanged(
    ForgotPasswordEmailChanged event,
    Emitter<ForgotPasswordState> emit,
  ) {
    emit(_form.copyWith(email: event.email));
  }

  void _onSubmitted(
    ForgotPasswordSubmitted event,
    Emitter<ForgotPasswordState> emit,
  ) {
    if (!_form.isEmailValid) return;

    emit(ForgotPasswordLoading());
    // TODO: Replace with repository call
    emit(ForgotPasswordSuccess());
  }
}
