import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../utils/ColorConstants.dart';
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
              color: CustomColors.primaryColorDark,
              // gradient: LinearGradient(
              //   colors: [gradientStartColor, gradientEndColor],
              //   begin: Alignment.topCenter,
              //   end: Alignment.bottomCenter,
              // ),
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
                  child: CachedNetworkImage(
                  height: Get.height*0.25,
                  width: double.infinity,
                              colorBlendMode: BlendMode.darken,
                                              imageUrl: thumbnailUrl,
                            placeholder: (context, url) => Image.asset(
                              'assets/default_image.png',
                              fit: BoxFit.cover // Set the height to match the diameter of the CircleAvatar
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              'assets/default_image.png',
                              fit: BoxFit.cover,
                              // Set the height to match the diameter of the CircleAvatar
                            ),
                            fit: BoxFit.cover,
                                            ),
              ),
                
                SizedBox(height: Get.height*0.005),
                ListTile(
                  leading:    ClipOval(
                  child: CircleAvatar(
                    radius: 28,
                    child: CachedNetworkImage(
                                      colorBlendMode: BlendMode.darken,
                                                      imageUrl: '',
                                    placeholder: (context, url) => ClipOval(
                                      child: Image.asset(
                                        'assets/profileicon.jpeg',
                                        fit: BoxFit.cover // Set the height to match the diameter of the CircleAvatar
                                      ),
                                    ),
                                    errorWidget: (context, url, error) => Image.asset(
                                      'assets/profileicon.jpeg',
                                      fit: BoxFit.cover,
                                      // Set the height to match the diameter of the CircleAvatar
                                    ),
                                    fit: BoxFit.cover,
                                                    ),
                  ),
                ),
                  title: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                      color: CustomColors.accentColor
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(channelName, style:const TextStyle(color: CustomColors.accentColor)),
                      Row(
                        children: [
                          Text(viewsCount, style:const TextStyle(color: CustomColors.accentColor)),
                         const SizedBox(width: 8.0),
                          Text(duration, style: const TextStyle(color: CustomColors.accentColor)),
                        ],
                      ),
                    ],
                  ),
                  trailing: const Icon(Icons.more_vert, color: CustomColors.accentColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
