import 'package:flutter/material.dart';
import 'package:flutter_basic/components/action_button.dart';
import 'package:flutter_basic/components/text_input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PasswordPage extends StatefulWidget {
  final String name;
  final String email;
  PasswordPage({super.key, required this.name, required this.email});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isPasswordValid = false;
  bool isConfirmPasswordValid = false;

  final heroAuthImage = 'assets/images/HeroAuth.svg';

  void validateFields() {
    final passwordValid = passwordController.text.length >= 8;
    final confirmPasswordValid =
        confirmPasswordController.text == passwordController.text;

    setState(() {
      isPasswordValid = passwordValid;
      isConfirmPasswordValid = confirmPasswordValid;
    });
  }

  void signUserUp(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: widget.email,
        password: passwordController.text,
      );
      Navigator.pop(context);
      // Navigate to the next page after registration is successful
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'weak-password') {
        weakPasswordMessage(context);
      }
    }
  }

  void weakPasswordMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('Password minimal 6 karakter'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                SvgPicture.asset(
                  heroAuthImage,
                  width: 393,
                  height: 322,
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 45),
                  child: Text(
                    'Buat akun dan pesan tiket event favoritmu dengan mudah!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF424242),
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                TextInputField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                  onChanged: (_) => validateFields(),
                ),
                const SizedBox(height: 15),
                TextInputField(
                  controller: confirmPasswordController,
                  hintText: 'Konfirmasi Password',
                  obscureText: true,
                  onChanged: (_) => validateFields(),
                ),
                const SizedBox(height: 25),
                ActionButton(
                  onTap: () {
                    if (passwordController.text.length >= 8 &&
                        passwordController.text ==
                            confirmPasswordController.text) {
                      signUserUp(context);
                    } else {
                      // Handle invalid password or password mismatch
                    }
                  },
                  text: "Daftar",
                  buttonColor: isPasswordValid && isConfirmPasswordValid
                      ? const Color(0xFFB4618D)
                      : Colors.grey, // Change button color conditionally
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
