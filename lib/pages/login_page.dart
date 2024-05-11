import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_basic/components/action_button.dart';
import 'package:flutter_basic/components/text_input_field.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final heroAuthImage = 'assets/images/HeroAuth.svg';
  bool isEmailValid = false;
  bool isPasswordValid = false;

  void validateFields() {
    final bool emailValid = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
        .hasMatch(emailController.text);
    final bool passwordValid = passwordController.text.length >= 8;
    setState(() {
      isEmailValid = emailValid;
      isPasswordValid = passwordValid;
    });
  }

  void signUserIn() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        wrongEmailMessage();
      } else if (e.code == 'wrong-password') {
        wrongPasswordMessage();
      } else if (e.code == 'invalid-email') {
        invalidEmailMessage();
      }
    }
  }

  void wrongEmailMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Kesalahan Saat Login'),
            content:
                Text('Email belum terdaftar. Buat akun baru dengan email ini?'),
          );
        });
  }

  void wrongPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Kesalahan Login',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Inter', fontWeight: FontWeight.w600, fontSize: 16),
          ),
          content: const Text('Email/password yang Anda masukkan salah'),
          actions: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color(0xFFB4618D),
              ),
              child: MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Kembali',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  void invalidEmailMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('Masukkan format email yang sesuai'),
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
                    'Masuk dan jelajahi pengalaman memesan tiket event favoritmu dengan mudah!',
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
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                  onChanged: (_) => validateFields(),
                ),
                const SizedBox(height: 15),
                TextInputField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                  onChanged: (_) => validateFields(),
                ),
                const SizedBox(height: 25),
                ActionButton(
                  onTap: isEmailValid && isPasswordValid ? signUserIn : null,
                  text: "Masuk",
                  buttonColor: isEmailValid && isPasswordValid
                      ? const Color(0xFFB4618D)
                      : Color(0xFFACACAC),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Belum punya akun?',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontFamily: 'Inter',
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Daftar',
                        style: TextStyle(
                          color: Color(0xFF0076B5),
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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
