import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basic/pages/my_ticket.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.lightBlue[700], actions: [
          IconButton(onPressed: signUserOut, icon: Icon(Icons.logout))
        ]),
        drawer: Drawer(
          child: Container(
            child: ListView(
              children: [
                DrawerHeader(
                    child: Center(
                  child: Image.asset('lib/images/logo2.png'),
                )),
                ListTile(
                  leading: Icon(Icons.airplane_ticket),
                  title: Text('Tiket saya'),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => myTicket()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.explore),
                  title: Text('Jelajahi event'),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => myTicket()));
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text('Tentang kami'),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => myTicket()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.help),
                  title: Text('Bantuan'),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => myTicket()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Pengaturan'),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => myTicket()));
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                  onTap: signUserOut,
                ),
              ],
            ),
          ),
        ),
        body: Center(
          child: Text("LOGGED IN AS: " + user.email!,
              style: TextStyle(fontSize: 20)),
        ));
  }
}
