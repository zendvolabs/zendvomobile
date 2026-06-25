import 'package:flutter_bloc/flutter_bloc.dart';
import 'create_new_password_event.dart';
import 'create_new_password_state.dart';

class CreateNewPasswordBloc
    extends Bloc<CreateNewPasswordEvent, CreateNewPasswordState> {
  CreateNewPasswordBloc() : super(const CreateNewPasswordFormState()) {
    on<PasswordChanged>(_onPasswordChanged);
    on<ConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<CreateNewPasswordSubmitted>(_onSubmitted);
  }

  CreateNewPasswordFormState get _form =>
      state is CreateNewPasswordFormState
          ? state as CreateNewPasswordFormState
          : const CreateNewPasswordFormState();

  void _onPasswordChanged(
    PasswordChanged event,
    Emitter<CreateNewPasswordState> emit,
  ) {
    emit(_form.copyWith(password: event.password));
  }

  void _onConfirmPasswordChanged(
    ConfirmPasswordChanged event,
    Emitter<CreateNewPasswordState> emit,
  ) {
    emit(_form.copyWith(confirmPassword: event.confirmPassword));
  }

  Future<void> _onSubmitted(
    CreateNewPasswordSubmitted event,
    Emitter<CreateNewPasswordState> emit,
  ) async {
    if (!_form.isFormValid) return;

    emit(CreateNewPasswordLoading());

    try {
      // TODO: Replace with real password reset repository call
      await Future.delayed(const Duration(seconds: 2));
      emit(CreateNewPasswordSuccess());
    } catch (e) {
      emit(CreateNewPasswordError(e.toString().replaceAll('Exception: ', '')));
    }
  }
}
