import 'package:flutter/material.dart';
import 'package:flutter_basic/pages/home/home_page.dart';
import 'package:flutter_basic/pages/home/profile/profile_loggedIn.dart';
import 'package:flutter_basic/pages/home/profile/profile_loggedOut.dart';
import 'package:flutter_basic/pages/home/my_ticket.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int myCurrentIndex = 0;
  late List<Widget> pages;

  @override
  void initState() {
    super.initState();
    pages = [
      HomePage(),
      ProfileLoggedIn(),
      MyProfile(onTap: () {
        setState(() {
          myCurrentIndex = 0;
        });
      }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: myCurrentIndex,
        onTap: (index) {
          setState(() {
            myCurrentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.airplane_ticket), label: "Ticket"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
      body: pages[myCurrentIndex],
    );
  }
}
