
import 'package:educationadmin/utils/ColorConstants.dart';
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
    return const Card(
      color: CustomColors.tileColour,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      elevation: 4,
      child: Padding(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'About Channel',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: CustomColors.accentColor),
        ),
        SizedBox(height: 16),
        Text(
          'Number of subscribers',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color:CustomColors.accentColor),
        ),
        Text('100K subscribers',style: TextStyle(color: CustomColors.secondaryColor)),
        SizedBox(height: 16),
        Text(
          'Description:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color:CustomColors.accentColor),
        ),
        Text(
          'This is a channel description. You can add a brief description of your channel and what it is about.',
        style: TextStyle(color: CustomColors.secondaryColor),),
        SizedBox(height: 16),
        Text(
          'Contact Information:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color:CustomColors.accentColor),
        ),
        Text('Email: channel@example.com',style: TextStyle(color: CustomColors.secondaryColor)),
        Text('Website: www.example.com',style: TextStyle(color: CustomColors.secondaryColor)),
      ],
    ),
      ),
    );
  }
}
