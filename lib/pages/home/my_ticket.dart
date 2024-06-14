import 'package:flutter/material.dart';
import 'package:flutter_basic/pages/home/detail_event.dart';
import 'package:flutter_basic/pages/home/detail_pemesanan.dart';

class MyTicket extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final purchasedEvents = PurchasedEvents.instance.purchasedEvents;

    Widget _buildEventCard(Map<dynamic, dynamic> event) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EventDetailPage(event: event),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(15.0)),
                  child: Image.asset(
                    'assets/images/12000e001.jpg',
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event['name'] ?? '',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0XFF1F2024),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        event['date'],
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0XFF71727A),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Rp. ${event['price']}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0XFF494A50),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('My Tickets'),
      ),
      body: ListView.builder(
        itemCount: purchasedEvents.length,
        itemBuilder: (context, index) {
          final event = purchasedEvents[index];
          return _buildEventCard(event);
        },
      ),
    );
  }
}
