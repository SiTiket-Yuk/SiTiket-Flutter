import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_basic/pages/auth/login_page.dart';
import 'package:flutter_basic/pages/home/profile/pusat_bantuan.dart';
import 'package:flutter_basic/pages/home/profile/tentang_sitiket.dart';

class MyProfile extends StatefulWidget {
  final Function()? onTap;
  const MyProfile({super.key, required this.onTap});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Container(
                height: 268,
                color: const Color(0xFF0076B5),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 70.0, left: 30.0, right: 30.0, bottom: 30.0),
                  child: Container(
                    height: 160,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16)),
                    padding: const EdgeInsets.only(
                        top: 40.0, left: 30.0, right: 100.0, bottom: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Bergabung dan pesan tiket event favoritmu dengan mudah!",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 15),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    LoginPage(onTap: widget.onTap),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                                top: 10.0,
                                left: 10.0,
                                right: 10.0,
                                bottom: 10.0),
                            margin: const EdgeInsets.only(right: 70),
                            decoration: BoxDecoration(
                              color: Color(0xFFB4618D),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Center(
                              child: Text(
                                "Masuk atau Daftar",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.all(20),
                  leading: Icon(Icons.help_outline, color: Color(0xFF0076B5)),
                  title: const Text(
                    'Pusat Bantuan',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400),
                  ),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PusatBantuan(),
                      ),
                    );
                  },
                ),
              ],
            ),
            Divider(
              color: Color(0XFFD4D6DD),
              height: 1,
              thickness: 0.5,
            ),
            ListTile(
              contentPadding: EdgeInsets.all(20),
              leading: Icon(Icons.info_outline, color: Color(0xFF0076B5)),
              title: const Text(
                'Tentang siTiket',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TentangSitiket(),
                  ),
                );
              },
            ),
            Divider(
              color: Color(0XFFD4D6DD),
              height: 1,
              thickness: 0.5,
            ),
          ],
        ),
      ),
    );
  }
}
