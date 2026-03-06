import 'package:flutter/material.dart';

import '../services/firebase_service.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key, required this.firebaseService});

  final FirebaseService firebaseService;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () async => firebaseService.signInWithGoogle(),
          icon: const Icon(Icons.login),
          label: const Text('Sign in with Google'),
        ),
      ),
    );
  }
}
