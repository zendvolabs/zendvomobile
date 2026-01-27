part of 'email_verification_bloc.dart';

abstract class EmailVerificationEvent extends Equatable {
  const EmailVerificationEvent();

  @override
  List<Object> get props => [];
}

class VerifyOTPEvent extends EmailVerificationEvent {
  final String otp;
  const VerifyOTPEvent(this.otp);

  @override
  List<Object> get props => [otp];
}

class ResendOTPEvent extends EmailVerificationEvent {
  const ResendOTPEvent();
}

class TimerTickedEvent extends EmailVerificationEvent {
  final int duration;
  const TimerTickedEvent(this.duration);

  @override
  List<Object> get props => [duration];
}
