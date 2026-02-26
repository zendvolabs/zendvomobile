import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginFormState extends LoginState {
  final String email;
  final String password;
  final bool isPasswordVisible;

  const LoginFormState({
    this.email = '',
    this.password = '',
    this.isPasswordVisible = false,
  });

  LoginFormState copyWith({
    String? email,
    String? password,
    bool? isPasswordVisible,
  }) {
    return LoginFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
    );
  }

  bool get isFormValid =>
      email.isNotEmpty &&
      email.contains('@') &&
      password.isNotEmpty &&
      password.length >= 8;

  @override
  List<Object?> get props => [email, password, isPasswordVisible];
}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final dynamic user;

  const LoginSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class LoginError extends LoginState {
  final String message;

  const LoginError(this.message);

  @override
  List<Object?> get props => [message];
}
