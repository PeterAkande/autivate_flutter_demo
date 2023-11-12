import 'package:authivate_demo/user_model.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  final User user;

  const UserProfileScreen({super.key, required this.user});

  static Route<void> route(User user) {
    return MaterialPageRoute(
      builder:   (_) => UserProfileScreen(user: user),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text('User Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person,
                  size: 150,
                ),
              ],
            ),
            const SizedBox(
              width: double.maxFinite,
              height: 20,
            ),
            Text(
              'First Name: ${user.firstName}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            Text(
              'Last Name: ${user.lastName}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            Text(
              'Email Address: ${user.emailAddress}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            Text(
              'User ID: ${user.userUniqueId}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            Text(
              'Is Verified: ${user.isVerified}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
