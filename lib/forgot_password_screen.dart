import 'package:authivate/authivate.dart';
import 'package:authivate_demo/loading_dialog.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute(
      builder: (_) => const ForgotPasswordScreen(),
    );
  }

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  // Function to simulate sending a password reset email
  Future<void> _sendPasswordResetEmail(BuildContext context) async {
    // Simulate sending a password reset email (replace with your actual logic)

    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter email"),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (_) => const LoadingDialog(alertInformation: 'Sending email..'),
    );

    final forgotPasswordResponse = await Authivate.instance
        .requestForgotPasswordForUser(
            emailAddress: _emailController.text.trim());

    if (!mounted) return;

    Navigator.of(context).pop();

    if (forgotPasswordResponse.isLeft()) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(forgotPasswordResponse.failureMessage),
          duration: const Duration(seconds: 2),
        ),
      );

      return;
    }


    // Show information (SnackBar)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Password reset email sent!"),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Email TextField
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Send Password Reset Email button
            SizedBox(
              width: double.maxFinite,
              height: 58,
              child: ElevatedButton(
                style: const ButtonStyle().copyWith(
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)))),
                onPressed: () => _sendPasswordResetEmail(context),
                child: const Text("Send Password Reset Email"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
