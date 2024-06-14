import 'package:flutter/material.dart';
import 'package:flutter_basic/components/action_button.dart';
import 'package:flutter_basic/pages/home/my_ticket.dart';

class DetailPemesanan extends StatefulWidget {
  final Map<dynamic, dynamic> event;

  const DetailPemesanan({super.key, required this.event});

  @override
  State<DetailPemesanan> createState() => _DetailPemesananState();
}

class _DetailPemesananState extends State<DetailPemesanan> {
  int _ticketCount = 1;

  void _incrementTicket() {
    setState(() {
      _ticketCount++;
    });
  }

  void _decrementTicket() {
    if (_ticketCount > 1) {
      setState(() {
        _ticketCount--;
      });
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Transaksi Berhasil',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          actions: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color(0xFFB4618D),
              ),
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyTicket(),
                    ),
                  );
                },
                child: const Text(
                  'Lihat Tiket',
                  style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _handlePayment() {
    PurchasedEvents.instance
        .addEvent(widget.event); // Add event to purchased events
    _showSuccessDialog();
  }

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
          "Detail Pemesanan",
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
            Text(
              widget.event['name'],
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              widget.event['organizer'],
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
                  widget.event['date'],
                  style: TextStyle(
                    color: Color(0XFF1F2024),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.access_time_rounded),
                SizedBox(
                  width: 10,
                ),
                Text(
                  widget.event['time'],
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Rp. ${widget.event['price']}'),
                Row(
                  children: [
                    IconButton(
                      onPressed: _decrementTicket,
                      icon: Icon(Icons.remove),
                    ),
                    Text('$_ticketCount'),
                    IconButton(
                      onPressed: _incrementTicket,
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Total Pembayaran: Rp. ${_ticketCount * widget.event['price']}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ActionButton(
              onTap: _handlePayment,
              text: 'Bayar',
              buttonColor: Color(0XFFB4618D),
            ),
          ],
        ),
      ),
    );
  }
}

class PurchasedEvents {
  PurchasedEvents._privateConstructor();

  static final PurchasedEvents instance = PurchasedEvents._privateConstructor();

  final List<Map<dynamic, dynamic>> _purchasedEvents = [];

  List<Map<dynamic, dynamic>> get purchasedEvents => _purchasedEvents;

  void addEvent(Map<dynamic, dynamic> event) {
    _purchasedEvents.add(event);
  }
}
