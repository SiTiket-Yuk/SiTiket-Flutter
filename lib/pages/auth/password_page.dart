import 'package:flutter/material.dart';
import 'package:flutter_basic/components/action_button.dart';
import 'package:flutter_basic/components/text_input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_basic/pages/home/home_page.dart';
import 'package:flutter_basic/pages/auth/login_page.dart';
import 'package:flutter_basic/pages/home/navbar.dart';
import 'package:flutter_basic/pages/auth/register_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PasswordPage extends StatefulWidget {
  final String name;
  final String email;
  final Function()? onTap;
  PasswordPage(
      {super.key,
      required this.name,
      required this.email,
      required this.onTap});

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
      builder: (BuildContext context) {
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
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Navbar()),
      );
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'email-already-in-use') {
        EmailAlreadyInUseMessage();
      }
    }
  }

  void EmailAlreadyInUseMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Email telah terdaftar',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          content: const Text('Lanjut masuk dengan email ini?'),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                RegisterPage(onTap: widget.onTap)),
                      );
                    },
                    child: const Text(
                      'Ubah Email',
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(onTap: widget.onTap),
                        ),
                      );
                    },
                    child: const Text(
                      'Masuk',
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
                    if (isPasswordValid && isConfirmPasswordValid) {
                      signUserUp(context);
                    } else {}
                  },
                  text: "Daftar",
                  buttonColor: isPasswordValid && isConfirmPasswordValid
                      ? const Color(0xFFB4618D)
                      : Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
