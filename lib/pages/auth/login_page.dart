import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basic/components/action_button.dart';
import 'package:flutter_basic/components/text_input_field.dart';
import 'package:flutter_basic/pages/auth/register_page.dart';
import 'package:flutter_basic/pages/home/home_page.dart';
import 'package:flutter_basic/pages/home/navbar.dart';
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
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Navbar()),
      );
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        notFoundEmailMessage();
      } else if (e.code == 'wrong-password') {
        wrongPasswordMessage();
      } else {
        showErrorMessage(e.code);
      }
    }
  }

  void notFoundEmailMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Kesalahan Login',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          content: const Text(
              'Email belum terdaftar. Buat akun baru dengan email ini?'),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Kembali',
                      style: TextStyle(color: Color(0xFFB4618D)),
                    ),
                  ),
                ),
                Container(
                  width: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xFFB4618D),
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                      widget.onTap?.call();
                    },
                    child: const Text(
                      'Buat Akun',
                      style:
                          TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
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

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(
              message,
            ),
          ),
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
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterPage(onTap: () {}),
                          ),
                        );
                      },
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
