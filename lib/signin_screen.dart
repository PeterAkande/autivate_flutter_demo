import 'package:authivate/authivate.dart';
import 'package:authivate_demo/forgot_password_screen.dart';
import 'package:authivate_demo/loading_dialog.dart';
import 'package:authivate_demo/signup_screen.dart';
import 'package:authivate_demo/user_details_screen.dart';
import 'package:authivate_demo/user_model.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute(
      builder: (_) => const SignInScreen(),
    );
  }

  @override
  SignInScreenState createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool showPassword = false;

  // Function to simulate a sign-in process
  Future<void> _signIn() async {
    // Validate email and password (you can add more validation as needed)
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter both email and password."),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // Show loading dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const LoadingDialog(alertInformation: 'Signing you in..');
      },
    );

    final signinResponse = await Authivate.instance.signInUser(
      emailAddress: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    if (!mounted) return;

    if (signinResponse.isLeft()) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(signinResponse.failureMessage),
          duration: const Duration(seconds: 2),
        ),
      );

      return;
    }

    final user = User.fromJson(signinResponse.successResponse);
    Navigator.of(context).push(UserProfileScreen.route(user));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text('Sign In Screen'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 60,
              ),
              // Email TextField
              TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  )),
              const SizedBox(height: 30),

              // Password TextField
              TextField(
                controller: _passwordController,
                obscureText: !showPassword,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: showPassword
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                  labelText: 'Password',
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(ForgotPasswordScreen.route());
                    },
                    child: const Text('Forgot password > '),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Sign-in button
              SizedBox(
                width: double.maxFinite,
                height: 58,
                child: ElevatedButton(
                  style: const ButtonStyle().copyWith(
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)))),
                  onPressed: _signIn,
                  child: const Text("Sign In"),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text('Don\'t have an account?'),
                  const SizedBox(
                    width: 2,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(SignUpScreen.route());
                    },
                    child: const Text('Sign-Up'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
