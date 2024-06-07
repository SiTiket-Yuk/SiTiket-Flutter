import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basic/pages/home/home_page.dart';
import 'package:flutter_basic/pages/auth/login_or_register_page.dart';
import 'package:flutter_basic/pages/home/navbar.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Navbar();
          } else {
            return const LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
