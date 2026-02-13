# Zendvo 
www.zendvo.com

Zendvo is a cross-platform mobile application built with Flutter for **iOS and Android**. It enables users to send cash gifts that remain completely hidden until a predetermined unlock date and time. By using the Stellar blockchain, Zendvo transforms digital money transfers into memorable experiences filled with mystery and anticipation.

## 🌟 Core Value Proposition

Transform digital money transfers into memorable experiences by adding mystery, anticipation, and celebration through time-locked gifts.

## 🚀 Key Features

- **Complete Invisibility**: Recipients cannot see the amount, sender identity, or message until the exact unlock moment.
- **Time-Locked Smart Contracts**: Secured using Soroban on the Stellar blockchain.
- **Multi-Channel Sharing**: Share gifts via WhatsApp, Telegram, QR Codes, or Universal Links.
- **Celebratory Unlock**: Immersive unlock animations and confetti for a memorable experience.
- **Easy Withdrawals**: Seamlessly withdraw USDC to Nigerian bank accounts via Paystack/Flutterwave.

## 💻 Technology Stack

- **Frontend**: Flutter (iOS & Android)
- **State Management**: BLoC (Business Logic Component)
- **Blockchain**: Stellar Network (Soroban Smart Contracts)
- **Currency**: USDC Stablecoin
- **Payments**: Stripe (Sender) & Paystack/Flutterwave (Recipient)

## 🏗️ Architecture

The project follows a **Feature-Based Clean Architecture** pattern:

```text
lib/
├── core/                  # Shared utilities and configuration
│   ├── constants/         # App constants and API endpoints
│   ├── error/             # Failure and Exception classes
│   ├── network/           # API clients and network logic
│   ├── theme/             # Design system (Colors, Typography)
│   ├── usecase/           # Generic UseCase interface
│   └── widgets/           # Global reusable UI components
└── features/              # Modularized feature folders
    └── [feature_name]/    # e.g., auth, gift_creation, withdrawal
        ├── data/          # Models, Datasources, Repository Impl
        ├── domain/        # Entities, Use Cases, Repository Interfaces
        └── presentation/  # BLoC, Pages, Feature-specific Widgets
```

## Benefits to the Stellar Ecosystem

Zendvo showcases the power of Stellar through:

1.  **Stablecoin Infrastructure:** Utilizing **USDC** for value preservation, ensuring that the gift amount remains stable from creation to unlock.
2.  **Soroban Smart Contracts:** Implementing decentralized time-locking logic that prevents early withdrawal, providing a middleman-free guarantee of the "hidden" nature of the gift.
3.  **Low-Cost Transactions:** Leveraging Stellar's high speed and near-zero fees to ensure that more of the sender's money reaches the recipient.
4.  **Real-World Utility:** Connecting blockchain technology directly to Nigerian bank accounts via local payout partners, driving adoption of Web3 solutions for real-world financial needs.
5.  **Financial Inclusion:** Providing a good on/off-ramp experience that bridges global stablecoin liquidity with local financial systems.

## Who is Zendvo For?

- **Diaspora Senders:** Specifically targeting young adults (18-35) in the US, UK, and Canada looking for a more meaningful way to send money home to Nigeria.
- **Domestic Gifting (Future Phase):** Nigerians sending to Nigerians for birthdays, anniversaries, and holidays where surprise is key.
- **Memorable Occasions:** Perfect for Valentine's Day, graduations, and surprise celebrations where the timing of the gift is as important as the gift itself.

## 🛠️ Development Setup

### Prerequisites

- Flutter SDK (latest stable)
- Dart SDK
- Stellar SDK configuration

### Getting Started

1. Clone the repository.
2. Run `flutter pub get` to fetch dependencies.
3. Use `flutter run` to launch on a connected device or emulator.

## 🛡️ Compliance & Security

- **Data Protection**: NDPR compliant.
- **Verification**: Phone-based OTP verification.
- **Trust**: Verified WhatsApp Business API integration.

---

Built with ❤️ by the Zendvo Team.
