import 'package:equatable/equatable.dart';

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  @override
  List<Object?> get props => [];
}

class ForgotPasswordFormState extends ForgotPasswordState {
  final String email;

  const ForgotPasswordFormState({
    this.email = '',
  });

  ForgotPasswordFormState copyWith({
    String? email,
  }) {
    return ForgotPasswordFormState(
      email: email ?? this.email,
    );
  }

  bool get isEmailValid =>
      email.isNotEmpty &&
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);

  @override
  List<Object?> get props => [email];
}

class ForgotPasswordLoading extends ForgotPasswordState {}

class ForgotPasswordSuccess extends ForgotPasswordState {}

class ForgotPasswordError extends ForgotPasswordState {
  final String message;

  const ForgotPasswordError(this.message);

  @override
  List<Object?> get props => [message];
}
