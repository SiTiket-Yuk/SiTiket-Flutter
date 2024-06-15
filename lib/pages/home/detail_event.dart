import 'package:flutter/material.dart';
import 'package:flutter_basic/pages/home/detail_pemesanan.dart';

class EventDetailPage extends StatelessWidget {
  final Map<dynamic, dynamic> event;

  const EventDetailPage({Key? key, required this.event}) : super(key: key);

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
          "Detail Event",
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
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  height: 200,
                  width: 380,
                  child: Image.network(event['imageEvent'],
                      errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                        'assets/images/default-event.png'); // default image asset
                  }),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              event['name'],
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              event['organizer'],
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Icon(Icons.date_range_outlined),
                SizedBox(
                  width: 10,
                ),
                Text(
                  event['date'],
                  style: TextStyle(
                    color: Color(0XFF1F2024),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Icon(Icons.access_time_rounded),
                SizedBox(
                  width: 10,
                ),
                Text(
                  event['time'],
                  style: TextStyle(
                    color: Color(0XFF1F2024),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              event['desc'],
              style: TextStyle(
                color: Color(0XFF1F2024),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rp. ${event['price']}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPemesanan(event: event),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 15),
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(
                      color: Color(0XFFB4618D),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'Beli Tiket',
                        style: const TextStyle(
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
          ],
        ),
      ),
    );
  }
}
