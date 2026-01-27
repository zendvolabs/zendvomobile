import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'email_verification_event.dart';
part 'email_verification_state.dart';

class EmailVerificationBloc
    extends Bloc<EmailVerificationEvent, EmailVerificationState> {
  Timer? _timer;
  static const int _initialTimerDuration = 60;

  EmailVerificationBloc() : super(EmailVerificationState.initial()) {
    on<VerifyOTPEvent>(_onVerifyOTP);
    on<ResendOTPEvent>(_onResendOTP);
    on<TimerTickedEvent>(_onTimerTicked);
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final currentDuration = state.timerDuration;
      if (currentDuration > 0) {
        add(TimerTickedEvent(currentDuration - 1));
      } else {
        _timer?.cancel();
      }
    });
  }

  Future<void> _onVerifyOTP(
    VerifyOTPEvent event,
    Emitter<EmailVerificationState> emit,
  ) async {
    if (event.otp.length != 6) {
      emit(
        state.copyWith(
          status: EmailVerificationStatus.failure,
          errorMessage: "Enter 6-digit code",
        ),
      );
      return;
    }

    emit(state.copyWith(status: EmailVerificationStatus.loading));

    await Future.delayed(const Duration(seconds: 2));
    if (event.otp == "123456") {
      _timer?.cancel();
      emit(state.copyWith(status: EmailVerificationStatus.success));
    } else {
      emit(
        state.copyWith(
          status: EmailVerificationStatus.failure,
          errorMessage: "Invalid verification code",
        ),
      );
    }
  }

  Future<void> _onResendOTP(
    ResendOTPEvent event,
    Emitter<EmailVerificationState> emit,
  ) async {
    if (!state.canResend) return;

    emit(state.copyWith(status: EmailVerificationStatus.resending));
    await Future.delayed(const Duration(seconds: 1));

    emit(
      state.copyWith(
        status: EmailVerificationStatus.initial,
        timerDuration: _initialTimerDuration,
        canResend: false,
      ),
    );
    _startTimer();
  }

  void _onTimerTicked(
    TimerTickedEvent event,
    Emitter<EmailVerificationState> emit,
  ) {
    emit(
      state.copyWith(
        timerDuration: event.duration,
        canResend: event.duration == 0,
      ),
    );
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
