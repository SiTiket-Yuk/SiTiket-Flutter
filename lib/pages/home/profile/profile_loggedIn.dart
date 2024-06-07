import 'package:flutter/material.dart';

class ProfileLoggedIn extends StatelessWidget {
  const ProfileLoggedIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20),
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
          SizedBox(height: 20),
          ListTile(
            leading: Icon(Icons.edit, color: Colors.blue),
            title: Text('Edit profil'),
            onTap: () {
              // Handle edit profile tap
            },
          ),
          ListTile(
            leading: Icon(Icons.help_outline, color: Colors.blue),
            title: Text('Pusat Bantuan'),
            onTap: () {
              // Handle help center tap
            },
          ),
          ListTile(
            leading: Icon(Icons.info_outline, color: Colors.blue),
            title: Text('Tentang siTiket'),
            onTap: () {
              // Handle about tap
            },
          ),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text('Keluar'),
            onTap: () {
              // Handle logout tap
            },
          ),
        ],
      ),
    );
    ;
  }
}
