import 'package:flutter/material.dart';
import 'package:zendvo/features/auth/presentation/widgets/signup_success_dialog.dart';

/// Test widget to verify the SignupSuccessDialog appearance and functionality
void main() {
  runApp(const SignupSuccessDialogTestApp());
}

class SignupSuccessDialogTestApp extends StatelessWidget {
  const SignupSuccessDialogTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Signup Success Dialog Test',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5E49E2),
          primary: const Color(0xFF5E49E2),
        ),
        fontFamily: 'BR Firma',
      ),
      home: const SignupSuccessDialogTestPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SignupSuccessDialogTestPage extends StatelessWidget {
  const SignupSuccessDialogTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Signup Success Dialog Test'),
        elevation: 0,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              barrierColor: Colors.black.withValues(alpha: 0.5),
              builder: (BuildContext context) {
                return SignupSuccessDialog(
                  emoji: '🎉',
                  allowBackdropDismiss: false,
                  onDismiss: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Dialog dismissed')),
                    );
                  },
                  onProceedToDashboard: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Proceeding to dashboard')),
                    );
                  },
                );
              },
            );
          },
          child: const Text('Show Signup Success Dialog'),
        ),
      ),
    );
  }
}
