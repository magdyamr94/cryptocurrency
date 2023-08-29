import 'package:flutter/material.dart';

class SupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFf7971E),
        title: Text('FAQ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Overview of Cryptocurrencies and Conversion Feature :',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Signika Negative',
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Digital currencies, also known as cryptocurrencies, are digital or virtual forms of money that use cryptography for secure transactions and control of new units. They operate on decentralized networks based on blockchain technology, which ensures transparency and immutability of transactions. Cryptocurrencies have gained significant attention in recent years due to their potential for revolutionizing the financial industry. Bitcoin, the first cryptocurrency, was introduced in 2009 by an anonymous person or group known as Satoshi Nakamoto.',
              style: TextStyle(fontFamily: 'Signika Negative', fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'A CryptoTo application is a software platform that allows users to track and interact with various cryptocurrencies. These apps provide real-time information about cryptocurrency prices, market capitalization, trading volumes, historical data, and more. One of the essential features of such applications is the ability to convert between different cryptocurrencies or traditional fiat currencies.',
              style: TextStyle(fontSize: 16, fontFamily: 'Signika Negative'),
            ),
            SizedBox(height: 36),
            Text(
              'For support, you can reach us via email at ',
              style: TextStyle(fontSize: 16, fontFamily: 'Signika Negative'),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              'magdyamr94@gmail.com ',
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Signika Negative',
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
