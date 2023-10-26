import 'package:flutter/material.dart';

class TimeOutScreen extends StatelessWidget {
  const TimeOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
          child: Center(
            child: Text('Could Not obtain data'),
          ),
      ),
    );
  }
}