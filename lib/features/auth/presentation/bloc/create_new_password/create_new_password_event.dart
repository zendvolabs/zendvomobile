import 'package:equatable/equatable.dart';

abstract class CreateNewPasswordEvent extends Equatable {
  const CreateNewPasswordEvent();

  @override
  List<Object?> get props => [];
}

class PasswordChanged extends CreateNewPasswordEvent {
  final String password;
  const PasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

class ConfirmPasswordChanged extends CreateNewPasswordEvent {
  final String confirmPassword;
  const ConfirmPasswordChanged(this.confirmPassword);

  @override
  List<Object?> get props => [confirmPassword];
}

class CreateNewPasswordSubmitted extends CreateNewPasswordEvent {}
