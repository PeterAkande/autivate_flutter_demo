import 'package:authivate/authivate.dart';
import 'package:authivate_demo/user_details_screen.dart';
import 'package:authivate_demo/user_model.dart';
import 'package:flutter/material.dart';
import 'loading_dialog.dart'; // Import your loading_dialog.dart file

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute(
      builder: (_) => const SignUpScreen(),
    );
  }

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool showPassword = false;
  final _formKey = GlobalKey<FormState>();

  // Function to simulate a sign-up process
  Future<void> _signUp() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Form is valid, proceed with sign-up
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const LoadingDialog(alertInformation: 'Signing you up..');
        },
      );

      final signUpResponse = await Authivate.instance.signUpUser(
        emailAddress: _emailController.text.trim(),
        lastName: _lastNameController.text.trim(),
        firstName: _firstNameController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (!mounted) return;

      if (signUpResponse.isLeft()) {
        // Close loading dialog
        Navigator.of(context).pop();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(signUpResponse.failureMessage),
            duration: const Duration(seconds: 2),
          ),
        );

        return;
      }

      final user = User.fromJson(signUpResponse.successResponse);
      Navigator.of(context).push(UserProfileScreen.route(user));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text('Sign Up Screen'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                // First Name TextField
                TextFormField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // Last Name TextField
                TextFormField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // Email TextField
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your email';
                    }
                    // You can add more email validation if needed
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // Password TextField
                TextFormField(
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
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your password';
                    }
                    // You can add more password validation if needed
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Sign-up button
                SizedBox(
                  width: double.maxFinite,
                  height: 58,
                  child: ElevatedButton(
                    style: ButtonStyle().copyWith(
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    onPressed: _signUp,
                    child: const Text("Sign Up"),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text('Already have an account?'),
                    const SizedBox(
                      width: 2,
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to sign-in screen
                        Navigator.of(context).pop();
                      },
                      child: const Text('Sign In'),
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
      ),
    );
  }
}
