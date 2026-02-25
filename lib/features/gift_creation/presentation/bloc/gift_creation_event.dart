import 'package:equatable/equatable.dart';

abstract class GiftCreationEvent extends Equatable {
  const GiftCreationEvent();

  @override
  List<Object?> get props => [];
}

/// Triggered when the user types a recipient phone number
class RecipientPhoneChanged extends GiftCreationEvent {
  final String phone;
  const RecipientPhoneChanged(this.phone);

  @override
  List<Object?> get props => [phone];
}

/// Triggered when the user taps the search / confirm button after entering phone
class RecipientLookupRequested extends GiftCreationEvent {
  final String countryCode;
  final String phone;
  const RecipientLookupRequested({
    required this.countryCode,
    required this.phone,
  });

  @override
  List<Object?> get props => [countryCode, phone];
}

/// Triggered when the amount field changes
class AmountChanged extends GiftCreationEvent {
  final double amount;
  const AmountChanged(this.amount);

  @override
  List<Object?> get props => [amount];
}

/// Triggered when a quick-amount chip is tapped
class QuickAmountSelected extends GiftCreationEvent {
  final double amount;
  const QuickAmountSelected(this.amount);

  @override
  List<Object?> get props => [amount];
}

/// Hide amount toggle
class HideAmountToggled extends GiftCreationEvent {
  final bool value;
  const HideAmountToggled(this.value);

  @override
  List<Object?> get props => [value];
}

/// Stay anonymous toggle
class StayAnonymousToggled extends GiftCreationEvent {
  final bool value;
  const StayAnonymousToggled(this.value);

  @override
  List<Object?> get props => [value];
}

/// Triggered when the user picks an unlock date
class UnlockDateSelected extends GiftCreationEvent {
  final DateTime date;
  const UnlockDateSelected(this.date);

  @override
  List<Object?> get props => [date];
}

/// Triggered when the user picks an unlock time
class UnlockTimeSelected extends GiftCreationEvent {
  final String time;
  const UnlockTimeSelected(this.time);

  @override
  List<Object?> get props => [time];
}

/// Triggered when the message field changes
class MessageChanged extends GiftCreationEvent {
  final String message;
  const MessageChanged(this.message);

  @override
  List<Object?> get props => [message];
}

/// Final submission event
class GiftSubmitted extends GiftCreationEvent {
  const GiftSubmitted();
}

/// Triggered from the Review screen when the user taps "Proceed"
class ProceedGiftPayment extends GiftCreationEvent {
  const ProceedGiftPayment();
}

// ── Sender Details Events ────────────────────────────────────────────────────

/// Triggered when the sender uploads an image
class SenderImageChanged extends GiftCreationEvent {
  final String imagePath;
  const SenderImageChanged(this.imagePath);

  @override
  List<Object?> get props => [imagePath];
}

/// Triggered when the sender types their name
class SenderNameChanged extends GiftCreationEvent {
  final String name;
  const SenderNameChanged(this.name);

  @override
  List<Object?> get props => [name];
}

/// Triggered when the sender types their email
class SenderEmailChanged extends GiftCreationEvent {
  final String email;
  const SenderEmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}

/// Triggered when the sender confirms their email
class SenderConfirmEmailChanged extends GiftCreationEvent {
  final String email;
  const SenderConfirmEmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}
