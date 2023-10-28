
import 'package:flutter/material.dart';

class DescriptionTab extends StatelessWidget {
  const DescriptionTab({
    super.key,
    required this.channelId,
    required this.createrId
  });
final int channelId;
final int createrId;
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'About Channel',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Channel Name',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('100K subscribers'),
            SizedBox(height: 16),
            Text(
              'Description:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'This is a channel description. You can add a brief description of your channel and what it is about.',
            ),
            SizedBox(height: 16),
            Text(
              'Contact Information:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('Email: channel@example.com'),
            Text('Website: www.example.com'),
          ],
        ),
      ),
    ));
  }
}
