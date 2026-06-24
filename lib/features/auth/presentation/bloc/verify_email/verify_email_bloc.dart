import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'verify_email_event.dart';
import 'verify_email_state.dart';

class VerifyEmailBloc extends Bloc<VerifyEmailEvent, VerifyEmailState> {
  Timer? _timer;

  VerifyEmailBloc() : super(const VerifyEmailFormState()) {
    on<VerifyEmailOtpChanged>(_onOtpChanged);
    on<VerifyEmailSubmitted>(_onSubmitted);
    on<VerifyEmailResendOtp>(_onResendOtp);
    on<VerifyEmailTimerTick>(_onTimerTick);

    _startTimer();
  }

  VerifyEmailFormState get _form =>
      state is VerifyEmailFormState
          ? state as VerifyEmailFormState
          : const VerifyEmailFormState();

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      add(VerifyEmailTimerTick());
    });
  }

  void _onTimerTick(
    VerifyEmailTimerTick event,
    Emitter<VerifyEmailState> emit,
  ) {
    if (_form.secondsRemaining > 0) {
      emit(_form.copyWith(secondsRemaining: _form.secondsRemaining - 1));
    } else {
      _timer?.cancel();
    }
  }

  void _onOtpChanged(
    VerifyEmailOtpChanged event,
    Emitter<VerifyEmailState> emit,
  ) {
    emit(_form.copyWith(otp: event.otp, hasError: false));
  }

  Future<void> _onSubmitted(
    VerifyEmailSubmitted event,
    Emitter<VerifyEmailState> emit,
  ) async {
    if (!_form.isOtpComplete) return;

    emit(VerifyEmailLoading());

    try {
      // TODO: Replace with real OTP verification API call
      await Future.delayed(const Duration(seconds: 2));

      emit(VerifyEmailSuccess());
    } catch (e) {
      emit(VerifyEmailError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  void _onResendOtp(
    VerifyEmailResendOtp event,
    Emitter<VerifyEmailState> emit,
  ) {
    if (!_form.canResend) return;

    // TODO: Replace with real resend OTP API call
    emit(_form.copyWith(secondsRemaining: 59, otp: '', hasError: false));
    _startTimer();
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
