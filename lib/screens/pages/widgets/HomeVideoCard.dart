import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
class HomeVideoCard extends StatelessWidget {
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

  HomeVideoCard({
    required this.thumbnailUrl,
    required this.title,
    required this.channelName,
    required this.viewsCount,
    required this.duration,
    required this.avatarUrl,
    required this.accentColor,
    required this.gradientStartColor,
    required this.gradientEndColor,
    required this.onTap,
  });

   @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        child: InkWell(
          onTap: onTap,
          child: Container(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(8.0)),
                  child: Image.network(thumbnailUrl, height: Get.height*0.25, width: double.infinity, fit: BoxFit.cover),
                ),
                SizedBox(height: Get.height*0.005),
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
                      Text(channelName, style:const TextStyle(color: Colors.white)),
                      Row(
                        children: [
                          Text(viewsCount, style:const TextStyle(color: Colors.white)),
                         const SizedBox(width: 8.0),
                          Text(duration, style: const TextStyle(color: Colors.white)),
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
      ),
    );
  }

}
