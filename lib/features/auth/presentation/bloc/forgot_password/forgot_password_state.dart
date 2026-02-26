import 'package:equatable/equatable.dart';

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  @override
  List<Object?> get props => [];
}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordFormState extends ForgotPasswordState {
  final String email;

  const ForgotPasswordFormState({this.email = ''});

  ForgotPasswordFormState copyWith({String? email}) {
    return ForgotPasswordFormState(email: email ?? this.email);
  }

  bool get isFormValid => email.isNotEmpty && email.contains('@');

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
