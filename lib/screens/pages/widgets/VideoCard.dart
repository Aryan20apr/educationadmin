import 'package:educationadmin/Modals/ChannelListModal.dart';
import 'package:educationadmin/screens/common/ChannelDetails.dart';
import 'package:educationadmin/screens/pages/creator/CreatorChannel.dart';
import 'package:educationadmin/screens/pages/creator/EditChannelScreen.dart';
import 'package:educationadmin/utils/ColorConstants.dart';
import 'package:educationadmin/utils/Flag.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'SubscriptionModalBottomSheet.dart';

class VideoCard extends StatelessWidget {
  final Color accentColor;
  final Color gradientStartColor;
  final Color gradientEndColor;
  final VoidCallback? onTap;
  final Channels channel;
  final ListType flag;
  final Function() onReturn;
  final Function() onPressed;
  const VideoCard(
      {super.key,
      required this.onReturn,
      required this.channel,
      required this.onPressed,
      required this.accentColor,
      required this.gradientStartColor,
      required this.gradientEndColor,
      this.onTap,
      required this.flag});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (flag == ListType.Creator) {
              Get.to(() => CreatorChannel(
                    channel: channel,
                  ));
            } else {
              if (!channel.isCompletelyPaid! || channel.price == 0) {
                Get.to(() => ChannelDetails(
                      channel: channel,
                    ));
              } else {
                // Get.defaultDialog(
                //   title: 'Attention',
                //   backgroundColor: CustomColors.secondaryColor,
                //   middleText: 'This content is not available free of cost.',
                //   //textConfirm: 'This content is not available free of cost',
                //   confirmTextColor: Colors.white,
                //   confirm: ElevatedButton(
                //       onPressed: () {
                //         Get.back();
                //       },
                //       style: ElevatedButton.styleFrom(
                //           backgroundColor: CustomColors.primaryColor,
                //           foregroundColor: CustomColors.secondaryColor),
                //       child: const Text('Ok')),
                // );
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return SubscriptionModalBottomSheet(channel: channel);
                  },
                );
              }
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(8.0)),
                child: CachedNetworkImage(
                  height: Get.height * 0.25,
                  width: double.infinity,
                  colorBlendMode: BlendMode.darken,
                  imageUrl: channel.thumbnail!,
                  placeholder: (context, url) => Image.asset(
                      'assets/default_image.png',
                      fit: BoxFit
                          .cover // Set the height to match the diameter of the CircleAvatar
                      ),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/default_image.png',
                    fit: BoxFit.cover,
                    // Set the height to match the diameter of the CircleAvatar
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8.0),
              ListTile(
                leading: ClipOval(
                  child: CircleAvatar(
                    radius: 28,
                    child: CachedNetworkImage(
                      colorBlendMode: BlendMode.darken,
                      imageUrl: '',
                      placeholder: (context, url) => ClipOval(
                        child: Image.asset('assets/profileicon.jpeg',
                            fit: BoxFit
                                .cover // Set the height to match the diameter of the CircleAvatar
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
                  channel.name ?? "",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                    color: CustomColors.accentColor,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('₹${channel.price ?? ""}',
                            style: const TextStyle(
                              color: CustomColors.accentColor,
                            )),
                        const SizedBox(width: 8.0),
                      ],
                    ),
                  ],
                ),
                trailing: flag == ListType.Creator
                    ? PopupMenuButton<String>(
                        icon: const Icon(
                          Icons.more_vert,
                          color: CustomColors.accentColor,
                        ), // Icon color is green
                        itemBuilder: flag == ListType.Creator
                            ? getCreatorItem
                            : getExploreItem,
                        onSelected: (value) async {
                          if (value == 'edit') {
                            await Get.to(() => EditChannel(channel: channel));
                            onReturn;
                            print('Edit selected');
                          } else if (value == 'delete') {
                            // Handle Delete option
                            print('Delete selected');
                            await _showDeleteConfirmationDialog(context);
                          } else if (value == 'subscribe') {
                             showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return SubscriptionModalBottomSheet(channel: channel);
                  },
                );
                          }
                        },
                      )
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 10,
                          shape: const ContinuousRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          backgroundColor: CustomColors.accentColor,
                          foregroundColor: CustomColors.primaryColorDark,
                        ),
                        onPressed: () {
                          if(channel.isCompletelyPaid!||channel.price!>0);
                          {
                             showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return SubscriptionModalBottomSheet(channel: channel);
                  },
                );
                          }
                        },
                        child: Text(
                          'Subscribe',
                          style: TextStyle(fontSize: 12.sp),
                        )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<PopupMenuEntry<String>> getExploreItem(context) {
    return <PopupMenuEntry<String>>[
      const PopupMenuItem<String>(
        value: 'subscribe',
        child: Row(
          children: <Widget>[
            // Edit icon is green

            Text('Subscribe', style: TextStyle(color: Colors.green)),
          ],
        ),
      ),
    ];
  }

  List<PopupMenuEntry<String>> getCreatorItem(context) {
    return <PopupMenuEntry<String>>[
      const PopupMenuItem<String>(
        value: 'edit',
        child: Row(
          children: <Widget>[
            Icon(Icons.edit, color: Colors.green), // Edit icon is green
            SizedBox(width: 8),
            Text('Edit', style: TextStyle(color: Colors.green)),
          ],
        ),
      ),
      const PopupMenuItem<String>(
        value: 'delete',
        child: Row(
          children: <Widget>[
            Icon(Icons.delete, color: Colors.green), // Delete icon is green
            SizedBox(width: 8),
            Text('Delete', style: TextStyle(color: Colors.green)),
          ],
        ),
      ),
    ];
  }

  Future<void> _showDeleteConfirmationDialog(BuildContext context) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Confirmation'),
          content: const Text('Are you sure you want to delete this channel?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              onPressed: onPressed,
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
