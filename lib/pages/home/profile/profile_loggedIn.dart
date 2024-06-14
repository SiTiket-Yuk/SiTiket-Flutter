import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basic/pages/home/profile/pusat_bantuan.dart';
import 'package:flutter_basic/pages/home/profile/tentang_sitiket.dart';

class ProfileLoggedIn extends StatelessWidget {
  const ProfileLoggedIn({super.key});

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 50),
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey.shade300,
            child: Icon(
              Icons.person,
              size: 40,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'User',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 50),
          Divider(
            color: Color(0XFFD4D6DD),
            height: 1,
            thickness: 0.5,
          ),
          ListTile(
            contentPadding: EdgeInsets.all(20),
            trailing: Icon(Icons.chevron_right),
            leading: Icon(Icons.edit, color: Colors.blue),
            title: Text('Edit profil'),
            onTap: () {
              // Handle edit profile tap
            },
          ),
          Divider(
            color: Color(0XFFD4D6DD),
            height: 1,
            thickness: 0.5,
          ),
          ListTile(
            contentPadding: EdgeInsets.all(20),
            trailing: Icon(Icons.chevron_right),
            leading: Icon(Icons.help_outline, color: Colors.blue),
            title: Text('Pusat Bantuan'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PusatBantuan(),
                ),
              );
            },
          ),
          Divider(
            color: Color(0XFFD4D6DD),
            height: 1,
            thickness: 0.5,
          ),
          ListTile(
            contentPadding: EdgeInsets.all(20),
            trailing: Icon(Icons.chevron_right),
            leading: Icon(Icons.info_outline, color: Colors.blue),
            title: Text('Tentang siTiket'),
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
          ListTile(
            contentPadding: EdgeInsets.all(20),
            trailing: Icon(Icons.chevron_right),
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text(
              'Keluar',
              style: TextStyle(color: Color(0XFFB30000)),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text(
                      'Apakah Anda yakin ingin keluar dari siTiket?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
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
                                Navigator.of(context).pop();
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
                                signUserOut();
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'Ya',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
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
    );
  }
}
