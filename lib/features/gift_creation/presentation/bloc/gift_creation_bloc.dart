import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zendvo/features/gift_creation/domain/models/recipient_model.dart';
import 'package:zendvo/features/gift_creation/presentation/bloc/gift_creation_event.dart';
import 'package:zendvo/features/gift_creation/presentation/bloc/gift_creation_state.dart';

/// GiftCreationBloc manages the entire Send-a-Gift form flow.
///
/// When you are ready to wire in real APIs, inject a GiftCreationRepository
/// (or use cases) through the constructor and call them in the appropriate
/// event handlers below.
class GiftCreationBloc extends Bloc<GiftCreationEvent, GiftCreationState> {
  GiftCreationBloc() : super(const GiftCreationFormState()) {
    on<RecipientPhoneChanged>(_onPhoneChanged);
    on<RecipientLookupRequested>(_onRecipientLookup);
    on<AmountChanged>(_onAmountChanged);
    on<QuickAmountSelected>(_onQuickAmountSelected);
    on<HideAmountToggled>(_onHideAmountToggled);
    on<StayAnonymousToggled>(_onStayAnonymousToggled);
    on<UnlockDateSelected>(_onUnlockDateSelected);
    on<UnlockTimeSelected>(_onUnlockTimeSelected);
    on<MessageChanged>(_onMessageChanged);
    on<GiftSubmitted>(_onGiftSubmitted);
    on<ProceedGiftPayment>(_onProceedGiftPayment);
    on<SenderImageChanged>(_onSenderImageChanged);
    on<SenderNameChanged>(_onSenderNameChanged);
    on<SenderEmailChanged>(_onSenderEmailChanged);
    on<SenderConfirmEmailChanged>(_onSenderConfirmEmailChanged);
  }

  GiftCreationFormState get _form => state is GiftCreationFormState
      ? state as GiftCreationFormState
      : const GiftCreationFormState();

  void _onPhoneChanged(
    RecipientPhoneChanged event,
    Emitter<GiftCreationState> emit,
  ) {
    // Clear the resolved recipient when the user edits the phone number
    emit(
      _form
          .copyWith(
            phone: event.phone,
            // Reset recipient — use explicit null via a workaround
          )
          .copyWith(),
    );
  }

  Future<void> _onRecipientLookup(
    RecipientLookupRequested event,
    Emitter<GiftCreationState> emit,
  ) async {
    emit(_form.copyWith(isLookingUpRecipient: true));

    // TODO: Replace the stub below with a real repository call, e.g.:
    // final result = await _repository.lookupRecipient(event.countryCode, event.phone);
    // result.fold(
    //   (failure) => emit(GiftCreationError(message: failure.message)),
    //   (recipient) => emit(_form.copyWith(recipient: recipient, isLookingUpRecipient: false)),
    // );

    // Stub – simulates a found user
    await Future.delayed(const Duration(milliseconds: 600));
    const stubRecipient = RecipientModel(
      phoneNumber: '8112345678',
      displayName: 'John Eze (NGN)',
      currency: 'NGN',
    );
    emit(
      _form.copyWith(
        countryCode: event.countryCode,
        phone: event.phone,
        recipient: stubRecipient,
        isLookingUpRecipient: false,
      ),
    );
  }

  void _onAmountChanged(AmountChanged event, Emitter<GiftCreationState> emit) {
    emit(_form.copyWith(amount: event.amount));
  }

  void _onQuickAmountSelected(
    QuickAmountSelected event,
    Emitter<GiftCreationState> emit,
  ) {
    emit(_form.copyWith(amount: event.amount));
  }

  void _onHideAmountToggled(
    HideAmountToggled event,
    Emitter<GiftCreationState> emit,
  ) {
    emit(_form.copyWith(hideAmount: event.value));
  }

  void _onStayAnonymousToggled(
    StayAnonymousToggled event,
    Emitter<GiftCreationState> emit,
  ) {
    emit(_form.copyWith(stayAnonymous: event.value));
  }

  void _onUnlockDateSelected(
    UnlockDateSelected event,
    Emitter<GiftCreationState> emit,
  ) {
    emit(_form.copyWith(unlockDate: event.date));
  }

  void _onUnlockTimeSelected(
    UnlockTimeSelected event,
    Emitter<GiftCreationState> emit,
  ) {
    emit(_form.copyWith(unlockTime: event.time));
  }

  void _onMessageChanged(
    MessageChanged event,
    Emitter<GiftCreationState> emit,
  ) {
    emit(_form.copyWith(message: event.message));
  }

  Future<void> _onGiftSubmitted(
    GiftSubmitted event,
    Emitter<GiftCreationState> emit,
  ) async {
    if (!_form.isFormValid) return;

    emit(const GiftCreationLoading());

    // TODO: Replace the stub below with a real repository call.
    // final payload = _form.toModel().toJson();
    // final result = await _repository.sendGift(payload);
    // result.fold(
    //   (failure) => emit(GiftCreationError(message: failure.message)),
    //   (code)    => emit(GiftCreationSuccess(giftCode: code)),
    // );

    await Future.delayed(const Duration(seconds: 1));
    emit(const GiftCreationSuccess(giftCode: 'GIFT-001'));
  }

  Future<void> _onProceedGiftPayment(
    ProceedGiftPayment event,
    Emitter<GiftCreationState> emit,
  ) async {
    emit(const GiftCreationLoading());

    // TODO: Replace the stub below with a real payment / gift confirmation call.
    // final result = await _repository.confirmGift(_form.toModel().toJson());
    // result.fold(
    //   (failure) => emit(GiftCreationError(message: failure.message)),
    //   (code)    => emit(GiftCreationSuccess(giftCode: code)),
    // );

    await Future.delayed(const Duration(seconds: 1));
    emit(const GiftCreationSuccess(giftCode: 'GIFT-CONFIRMED'));
  }

  // ── Sender Details Handlers ──────────────────────────────────────────────────

  void _onSenderImageChanged(
    SenderImageChanged event,
    Emitter<GiftCreationState> emit,
  ) {
    emit(_form.copyWith(senderImage: event.imagePath));
  }

  void _onSenderNameChanged(
    SenderNameChanged event,
    Emitter<GiftCreationState> emit,
  ) {
    emit(_form.copyWith(senderName: event.name));
  }

  void _onSenderEmailChanged(
    SenderEmailChanged event,
    Emitter<GiftCreationState> emit,
  ) {
    emit(_form.copyWith(senderEmail: event.email));
  }

  void _onSenderConfirmEmailChanged(
    SenderConfirmEmailChanged event,
    Emitter<GiftCreationState> emit,
  ) {
    emit(_form.copyWith(senderConfirmEmail: event.email));
  }
}
