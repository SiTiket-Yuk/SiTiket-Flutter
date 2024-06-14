import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basic/pages/home/home_page.dart';
import 'package:flutter_basic/pages/home/navbar.dart';
import 'package:flutter_basic/pages/home/profile/profile_loggedIn.dart';
import 'package:flutter_basic/pages/home/profile/profile_loggedOut.dart';

class ProfileLoggedInOrNot extends StatelessWidget {
  const ProfileLoggedInOrNot({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ProfileLoggedIn();
          } else {
            return MyProfile(onTap: () {});
          }
        },
      ),
    );
  }
}
