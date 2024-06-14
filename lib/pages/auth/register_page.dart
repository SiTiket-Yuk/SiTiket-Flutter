import 'package:flutter/material.dart';
import 'package:flutter_basic/components/action_button.dart';
import 'package:flutter_basic/components/text_input_field.dart';
import 'package:flutter_basic/pages/auth/login_page.dart';
import 'package:flutter_basic/pages/auth/password_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  final heroAuthImage = 'assets/images/HeroAuth.svg';

  bool isNameValid = false;
  bool isEmailValid = false;

  void validateFields() {
    final bool nameValid = nameController.text.isNotEmpty;
    final bool emailValid = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
        .hasMatch(emailController.text);
    setState(() {
      isNameValid = nameValid;
      isEmailValid = emailValid;
    });
  }

  void navigateToPasswordPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PasswordPage(
          name: nameController.text,
          email: emailController.text,
          onTap: widget.onTap,
        ),
      ),
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
                  controller: nameController,
                  hintText: 'Nama Lengkap',
                  obscureText: false,
                  onChanged: (_) => validateFields(),
                ),
                const SizedBox(height: 15),
                TextInputField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                  onChanged: (_) => validateFields(),
                ),
                const SizedBox(height: 25),
                ActionButton(
                  onTap: isNameValid && isEmailValid
                      ? navigateToPasswordPage
                      : null,
                  text: "Selanjutnya",
                  buttonColor: isNameValid && isEmailValid
                      ? const Color(0xFFB4618D)
                      : Colors.grey,
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sudah punya akun?',
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
                            builder: (context) => LoginPage(onTap: () {}),
                          ),
                        );
                      },
                      child: const Text(
                        'Masuk',
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
