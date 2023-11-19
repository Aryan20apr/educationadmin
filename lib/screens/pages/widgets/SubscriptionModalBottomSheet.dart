import 'package:flutter/material.dart';

class SubscriptionModalBottomSheet extends StatelessWidget {
  const SubscriptionModalBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Modal Bottom Sheet Title',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10.0),
          const Text(
            'This is the first text widget in the bottom sheet.',
            style: TextStyle(fontSize: 16.0),
          ),
          const SizedBox(height: 10.0),
          const Text(
            'This is the second text widget in the bottom sheet.',
            style: TextStyle(fontSize: 16.0),
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              // Add your button functionality here
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Elevated Button',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}