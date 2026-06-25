import 'package:equatable/equatable.dart';

abstract class VerifyEmailState extends Equatable {
  const VerifyEmailState();

  @override
  List<Object?> get props => [];
}

class VerifyEmailFormState extends VerifyEmailState {
  final String otp;
  final int secondsRemaining;
  final bool hasError;
  final String? errorMessage;

  const VerifyEmailFormState({
    this.otp = '',
    this.secondsRemaining = 59,
    this.hasError = false,
    this.errorMessage,
  });

  bool get canResend => secondsRemaining <= 0;
  bool get isOtpComplete => otp.length == 6;

  VerifyEmailFormState copyWith({
    String? otp,
    int? secondsRemaining,
    bool? hasError,
    String? errorMessage,
  }) {
    return VerifyEmailFormState(
      otp: otp ?? this.otp,
      secondsRemaining: secondsRemaining ?? this.secondsRemaining,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [otp, secondsRemaining, hasError, errorMessage];
}

class VerifyEmailLoading extends VerifyEmailState {}

class VerifyEmailSuccess extends VerifyEmailState {}

class VerifyEmailError extends VerifyEmailState {
  final String message;

  const VerifyEmailError(this.message);

  @override
  List<Object?> get props => [message];
}
