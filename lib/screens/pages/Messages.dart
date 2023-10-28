import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';



class Chat {
  final String name;
  final String message;
  final String time;

  Chat(this.name, this.message, this.time);
}

class ChatScreen extends StatelessWidget {
  final List<Chat> chats = [
    Chat("Alice", "Hello!", "10:00 AM"),
    Chat("Bob", "Hi there!", "10:05 AM"),
    Chat("Charlie", "How are you?", "10:10 AM"),
    Chat("David", "Good morning!", "10:15 AM"),
    // Add more chat entries here
  ];

  @override
  Widget build(BuildContext context) {
    return 
       Scaffold(
        appBar: AppBar(
          title: Text("WhatsApp"),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // Handle search action
              },
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {
                // Handle more options action
              },
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: chats.length,
          itemBuilder: (context, index) {
            final chat = chats[index];
            return ListTile(
              leading: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage('https://via.placeholder.com/80x80'),
              ),
              title: Text(chat.name),
              subtitle: Text(chat.message),
              trailing: Text(chat.time),
              onTap: () {
                // Handle chat selection
                // Navigate to chat screen or show chat details
              },
            );
          },
        ),
      );
    
  }
}
