import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute(
      builder: (_) => const ResetPasswordScreen(),
    );
  }

  @override
  ResetPasswordScreenState createState() => ResetPasswordScreenState();
}

class ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // Function to simulate resetting the password
  Future<void> _resetPassword(BuildContext context) async {
    // Validate passwords
    if (_newPasswordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Passwords do not match!"),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // Simulate resetting the password (replace with your actual logic)
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // Show information (SnackBar)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Password reset successful!"),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // New Password TextField
            TextField(
              controller: _newPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'New Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Confirm Password TextField
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirm Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Reset Password button
            SizedBox(
              width: double.maxFinite,
              height: 58,
              child: ElevatedButton(
                onPressed: () => _resetPassword(context),
                child: const Text("Reset Password"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
