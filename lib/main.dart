import 'package:authivate_demo/signin_screen.dart';
import 'package:flutter/material.dart';

import 'package:authivate/authivate.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    super.initState();

    final config = AuthivateConfig(
      apiKey: '5fa9e98c106ac3a3a91dfca29f7cab62a9ccf03d',
      projectId: 'authivate-demo',
    );

    final authivateInstance = Authivate(config: config);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SignInScreen(),
    );
  }
}
