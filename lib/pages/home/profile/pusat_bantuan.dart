import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PusatBantuan extends StatelessWidget {
  const PusatBantuan({super.key});

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
          "Pusat Bantuan",
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
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Paling sering ditanya',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Expanded(
              child: ListView(
                children: [
                  QuestionItem(
                      question: 'Ganti nama pemesan di tiket elektronik'),
                  SizedBox(
                    height: 12,
                  ),
                  QuestionItem(question: 'Apakah tiket bisa di refund'),
                  SizedBox(
                    height: 12,
                  ),
                  QuestionItem(
                      question:
                          'Saya hanya menerima 1 tiket padahal membayar lebih dari 1 tiket'),
                  SizedBox(
                    height: 12,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Center(
                      child: Text(
                        'Lihat pertanyaan lainnya',
                        style: TextStyle(
                            color: Color(0XFF0076B5),
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuestionItem extends StatelessWidget {
  final String question;
  const QuestionItem({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Color(0XFFDCDCDC),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        question,
        style: TextStyle(fontSize: 16, color: Color(0XFF414141)),
      ),
    );
  }
}
