part of 'email_verification_bloc.dart';

enum EmailVerificationStatus { initial, loading, success, failure, resending }

class EmailVerificationState extends Equatable {
  final EmailVerificationStatus status;
  final String? errorMessage;
  final int timerDuration;
  final bool canResend;

  const EmailVerificationState({
    required this.status,
    this.errorMessage,
    required this.timerDuration,
    required this.canResend,
  });

  factory EmailVerificationState.initial() {
    return const EmailVerificationState(
      status: EmailVerificationStatus.initial,
      timerDuration: 60,
      canResend: false,
    );
  }

  EmailVerificationState copyWith({
    EmailVerificationStatus? status,
    String? errorMessage,
    int? timerDuration,
    bool? canResend,
  }) {
    return EmailVerificationState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      timerDuration: timerDuration ?? this.timerDuration,
      canResend: canResend ?? this.canResend,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, timerDuration, canResend];
}
