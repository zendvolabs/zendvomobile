import 'package:equatable/equatable.dart';

abstract class CreateNewPasswordState extends Equatable {
  const CreateNewPasswordState();

  @override
  List<Object?> get props => [];
}

class CreateNewPasswordFormState extends CreateNewPasswordState {
  final String password;
  final String confirmPassword;

  const CreateNewPasswordFormState({
    this.password = '',
    this.confirmPassword = '',
  });

  static final _passwordRegex = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~%^()\-_=+\[\]{}|;:,.<>?]).{8,}$',
  );

  bool get isPasswordValid => _passwordRegex.hasMatch(password);
  bool get doPasswordsMatch =>
      password.isNotEmpty && password == confirmPassword;
  bool get isFormValid => isPasswordValid && doPasswordsMatch;

  CreateNewPasswordFormState copyWith({
    String? password,
    String? confirmPassword,
  }) {
    return CreateNewPasswordFormState(
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }

  @override
  List<Object?> get props => [password, confirmPassword];
}

class CreateNewPasswordLoading extends CreateNewPasswordState {}

class CreateNewPasswordSuccess extends CreateNewPasswordState {}

class CreateNewPasswordError extends CreateNewPasswordState {
  final String message;
  const CreateNewPasswordError(this.message);

  @override
  List<Object?> get props => [message];
}
