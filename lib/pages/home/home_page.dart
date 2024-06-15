import 'package:flutter/material.dart';
import 'package:flutter_basic/pages/home/detail_event.dart';
import 'package:flutter_basic/pages/home/search_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.ref('events');
  final _firebaseStorage = FirebaseStorage.instance.ref();
  List<Map<dynamic, dynamic>> _events = [];

  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  Future<void> _fetchEvents() async {
    try {
      final DataSnapshot snapshot = await _databaseReference.get();
      if (snapshot.exists) {
        final Map<dynamic, dynamic> eventsMap =
            snapshot.value as Map<dynamic, dynamic>;

        List<Future<Map<dynamic, dynamic>>> futures =
            eventsMap.entries.map((entry) async {
          String eventId = entry.key;
          Map<dynamic, dynamic> event = entry.value;

          // Fetch images for the event
          String imageEvent = await _fetchImageUrl(eventId, 'jpg');
          String organizerLogo = await _fetchImageUrl('${eventId}_org', 'png');

          print(imageEvent);

          return {
            ...event,
            'id': eventId,
            'imageEvent': imageEvent,
            'organizerLogo': organizerLogo,
          };
        }).toList();

        List<Map<dynamic, dynamic>> eventsWithImages =
            await Future.wait(futures);

        setState(() {
          _events = eventsWithImages;
        });
      } else {
        print('No data available.');
      }
    } catch (e) {
      print('Error fetching events: $e');
    }
  }

  Future<String> _fetchImageUrl(String imagePath, String extension) async {
    final imageName = '$imagePath.$extension';
    try {
      final imageRef = _firebaseStorage.child(imageName);
      return await imageRef.getDownloadURL();
    } catch (e) {
      return "";
    }
  }

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
                height: 120,
                color: Color(0xFF0076B5),
                child: const Padding(
                  padding: EdgeInsets.only(
                      top: 70.0, left: 40.0, right: 40.0, bottom: 20.0),
                  child: Text(
                    'Temukan Event Seru Hari Ini!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 15.0, left: 50.0, right: 50.0, bottom: 15.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchPage(events: _events),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffF9F9F9),
                    borderRadius: BorderRadius.circular(24.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      hintText: 'Cari event',
                      hintStyle: TextStyle(fontSize: 16),
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.transparent,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCategoryIcon('Festival', 'assets/images/festival.svg'),
                  _buildCategoryIcon('Bisnis', 'assets/images/bisnis.svg'),
                  _buildCategoryIcon('Workshop', 'assets/images/workshop.svg'),
                  _buildCategoryIcon('Webinar', 'assets/images/webinar.svg'),
                  _buildCategoryIcon('Olahraga', 'assets/images/olahraga.svg'),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.asset(
                  'assets/images/event.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(
                  top: 15.0, left: 15.0, right: 200.0, bottom: 15.0),
              child: Text(
                'Berlangsung Minggu Ini',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ..._events.map((event) => _buildEventCard(event)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryIcon(String label, String assetPath) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFDFF2FA),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(assetPath),
          ),
        ),
        SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }

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
                borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
                child: Image.network(
                  event['imageEvent'] ??
                      'https://example.com/default-image.jpg', // default image URL
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                        'assets/images/default-event.png'); // default image asset
                  },
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
}
