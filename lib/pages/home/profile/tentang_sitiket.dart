import 'package:flutter/material.dart';

class TentangSitiket extends StatelessWidget {
  const TentangSitiket({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xFFB4618D),
          ),
        ),
        title: const Text(
          "Tentang siTiket",
          style: TextStyle(
              fontSize: 16, fontFamily: 'Inter', fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(10.0),
          child: Container(
            height: 1.0,
            color: Color(0XFFD4D6DD),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  height: 200,
                  width: 380,
                  child: Image.asset(
                    'assets/images/LogoDarkWithName.png',
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              'siTiket adalah platform Ticketing Management Service (TMS) yang mendukung seluruh penyelenggara event mulai dari distribusi & manajemen tiket. siTiket menawarkan akses mudah dan cepat ke berbagai acara, mulai dari konser musik, pertunjukan teater, hingga acara olahraga dan seminar inspiratif.',
              style: TextStyle(
                color: Color(0XFF1F2024),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Dengan antarmuka yang ramah pengguna dan sistem yang efisien, siTiket memastikan setiap langkah  pembelian tiket anda berlangsung dengan lancar dan mudah.',
              style: TextStyle(
                color: Color(0XFF1F2024),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Sudah ada ratusan event yang bekerja sama dengan kami dan semuanya tersebar di seluruh Indonesia. Kini, saatnya perkenalkan event Anda pada dunia untuk membawa penonton yang lebih banyak lagi bersama kami!',
              style: TextStyle(
                color: Color(0XFF1F2024),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }
}
