

import 'dart:developer';
import 'package:logger/logger.dart';
import 'package:educationadmin/screens/pages/Explore2.dart';
import 'package:educationadmin/screens/pages/creator/CreateChannel.dart';
import 'package:educationadmin/screens/pages/creator/CreateChannelsController.dart';
import 'package:educationadmin/screens/pages/creator/CreatorChannel.dart';
import 'package:educationadmin/utils/ColorConstants.dart';
import 'package:educationadmin/utils/Controllers/UserController.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../Modals/ChannelListModal.dart';

class CreaterHome extends StatefulWidget {

  const CreaterHome({super.key});

  @override
  State<CreaterHome> createState() => _CreaterHomeState();
}

class _CreaterHomeState extends State<CreaterHome> {
  final UserDetailsManager userDetailsManager = Get.find<UserDetailsManager>();
  final CreaterChannelsController createrChannelsController=Get.put(CreaterChannelsController());
  Future<bool>? isChannelFetched;
  final Logger logger=Logger();
  @override
  void initState()
  {
    super.initState();
    logger.e("In initState");
    isChannelFetched=createrChannelsController.getChannels();
  }
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
            child: FutureBuilder<bool>(
              future: isChannelFetched,
              builder: (context,snapshot) {
                if(ConnectionState.waiting==snapshot.connectionState)
                {
                    return const ProgressIndicatorWidget();
                }
                else if(ConnectionState.done==snapshot.connectionState)
                {
                  if(snapshot.data==false)
                  {
                    return const Center(child: Text('Could not obtain channels'),);
                  }
                  else
                  {
                    if(createrChannelsController.channelData.value.channels!.isNotEmpty)
                    {
                      return Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: createrChannelsController.channelData.value.channels?.length,
                      itemBuilder: (context, index) {
                        return VideoCard(
                          channel:createrChannelsController.channelData.value.channels![index],
                         
                          accentColor: ColorConstants.accentColor,
                          gradientStartColor: ColorConstants.primaryColor,
                          gradientEndColor: ColorConstants.secondaryColor,
                        );
                      },
                    ),
                  ],
                );
                    }
                    else
                    {
                      return const Center(child: Text('No channels available'),);
                    }
                  }
                }
                else
                {
                  return const ProgressIndicatorWidget();
                }
              }
            ),
          ),
        ],
      ),
    );
  }
}

class VideoCard extends StatelessWidget {
 
  final Color accentColor;
  final Color gradientStartColor;
  final Color gradientEndColor;
  final VoidCallback? onTap;
  final Channels channel;
  const VideoCard({super.key, 
    required this.channel,
    
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
            Get.to(() => CreatorChannel(channel: channel,));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(8.0)),
                child: Image.network(channel.thumbnail!,
                    height: 200.0, width: double.infinity, fit: BoxFit.cover),
              ),
              const SizedBox(height: 8.0),
              ListTile(
                leading: const CircleAvatar(
                  backgroundImage: NetworkImage("https://via.placeholder.com/40x40"),
                ),
                title: Text(
                  channel.name??"",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                    color: Colors.white,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   
                    Row(
                      children: [
                        Text('₹${channel.price??""}',
                            style: const TextStyle(color: Colors.white)),
                        const SizedBox(width: 8.0),
                       
                      ],
                    ),
                  ],
                ),
                trailing: const Icon(Icons.more_vert_rounded, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
