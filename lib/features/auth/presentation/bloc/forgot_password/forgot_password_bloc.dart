import 'package:flutter_bloc/flutter_bloc.dart';
import 'forgot_password_event.dart';
import 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
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

  Future<void> _onSubmitted(
    ForgotPasswordSubmitted event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    if (!_form.isFormValid) return;

    final cachedForm = _form;
    emit(ForgotPasswordLoading());

    // TODO: Replace with real authentication/repository call
    await Future.delayed(const Duration(seconds: 2));

    // Simulate success
    emit(ForgotPasswordSuccess());

    // Reset to form internally (or navigate away via BlocListener)
  }
}
