import 'package:equatable/equatable.dart';

abstract class VerifyEmailEvent extends Equatable {
  const VerifyEmailEvent();

  @override
  List<Object?> get props => [];
}

class VerifyEmailOtpChanged extends VerifyEmailEvent {
  final String otp;

  const VerifyEmailOtpChanged(this.otp);

  @override
  List<Object?> get props => [otp];
}

class VerifyEmailSubmitted extends VerifyEmailEvent {}

class VerifyEmailResendOtp extends VerifyEmailEvent {}

class VerifyEmailTimerTick extends VerifyEmailEvent {}
