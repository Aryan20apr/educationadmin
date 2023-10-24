import 'package:educationadmin/screens/pages/creator/CreateChannel.dart';
import 'package:educationadmin/screens/pages/creator/CreatorChannel.dart';
import 'package:educationadmin/utils/ColorConstants.dart';
import 'package:educationadmin/utils/Controllers/UserController.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class CreaterHome extends StatelessWidget {
  final UserDetailsManager userDetailsManager = Get.find<UserDetailsManager>();

  CreaterHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorConstants.secondaryColor,
        foregroundColor: Colors.white,
        onPressed: () {
          Get.to(()=>const CreateChannel());
        },
        elevation: 20.0,
        highlightElevation: 50,
        child:const Icon(Icons.add),
      ),
      body: ListView(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.tealAccent,
                  Colors.teal
                ], // Light gradient background
              ),
            ),
            padding: const EdgeInsets.all(16.0),
            child: LayoutBuilder(
              builder: (context, usercardconstra) {
                return Row(
                  children: [
                    SizedBox(width: Get.width * 0.05),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Channels', // Replace with the user's name
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.textColor,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.01),
                        Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              size: 12.sp,
                              color: ColorConstants.accentColor,
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              '123K Total Followers', // Replace with user-related details
                              style: TextStyle(
                                color: ColorConstants.textColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white, // Background color of the bottom sheet
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16.0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[300]!,
                  offset: const Offset(0, -2),
                  blurRadius: 3.0,
                ),
              ],
            ),
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return VideoCard(
                      thumbnailUrl: 'https://via.placeholder.com/400x200',
                      title: 'Channel Title $index',
                      channelName: 'Channel Name',
                      viewsCount: '1M Subscribers',
                      duration: '10:00',
                      avatarUrl: 'https://via.placeholder.com/40x40',
                      accentColor: ColorConstants.accentColor,
                      gradientStartColor: ColorConstants.primaryColor,
                      gradientEndColor: ColorConstants.secondaryColor,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class VideoCard extends StatelessWidget {
  final String thumbnailUrl;
  final String title;
  final String channelName;
  final String viewsCount;
  final String duration;
  final String avatarUrl;
  final Color accentColor;
  final Color gradientStartColor;
  final Color gradientEndColor;
  final VoidCallback? onTap;

  VideoCard({
    required this.thumbnailUrl,
    required this.title,
    required this.channelName,
    required this.viewsCount,
    required this.duration,
    required this.avatarUrl,
    required this.accentColor,
    required this.gradientStartColor,
    required this.gradientEndColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        gradient: LinearGradient(
          colors: [gradientStartColor, gradientEndColor],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300]!,
            offset: const Offset(0, 2),
            blurRadius: 3.0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Get.to(() => const CreatorChannel());
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(8.0)),
                child: Image.network(thumbnailUrl,
                    height: 200.0, width: double.infinity, fit: BoxFit.cover),
              ),
              const SizedBox(height: 8.0),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(avatarUrl),
                ),
                title: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                    color: Colors.white,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(channelName,
                        style: const TextStyle(color: Colors.white)),
                    Row(
                      children: [
                        Text(viewsCount,
                            style: const TextStyle(color: Colors.white)),
                        const SizedBox(width: 8.0),
                        Text(duration,
                            style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                  ],
                ),
                trailing: const Icon(Icons.more_vert, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
