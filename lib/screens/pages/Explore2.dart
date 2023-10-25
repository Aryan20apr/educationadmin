import 'package:cached_network_image/cached_network_image.dart';
import 'package:educationadmin/authentication/viewmodal/ExploreViewModal.dart';
import 'package:educationadmin/screens/ChannelDetails.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';


class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  ExploreViewModal exploreViewModal = Get.put(ExploreViewModal());

  @override
  Widget build(BuildContext context) {
    final primaryColor = const Color(0xFF3D5AFE); // Primary Color - Indigo
    final accentColor = const Color(0xFFFF8F00); // Accent Color - Amber
    final textColor = const Color(0xFF212121); // Text Color - Black
    final cardBackgroundColor = const Color(0xFFE6F0FF); // Light blue gradient background

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Explore Courses',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: primaryColor, // Set app bar title color
          ),
        ),
        backgroundColor: Colors.white, // Set app bar background color to white
        elevation: 0, // Remove app bar elevation
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverFillRemaining(
            child: FutureBuilder(
              future: exploreViewModal.getChannels(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const ProgressIndicatorWidget();
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (exploreViewModal.channelData.value.channels == null) {
                    return const Center(child: Text('Could not obtain channels'));
                  }
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: Get.height * 0.5,
                        width: Get.width * 0.95,
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(() => ChannelDetails(
                                        channel: exploreViewModal
                                            .channelData.value.channels![index],
                                      ));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                    color: cardBackgroundColor, // Set card background color
                                  ),
                                  margin: const EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      // Title and subtitle
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                '${exploreViewModal.channelData.value.channels![index].name}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14.sp,
                                                  color: textColor, // Set text color
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              'Created by ${exploreViewModal.channelData.value.channels![index].createdBy}',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      // Network image
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CachedNetworkImage(
                                          colorBlendMode: BlendMode.darken,
                                          imageUrl: '${exploreViewModal.channelData.value.channels![index].thumbnail}',
                                          placeholder: (context, url) =>
                                              Image.asset('assets/default_image.png'),
                                          errorWidget: (context, url, error) =>
                                              Image.asset('assets/default_image.png'),
                                          height: constraints.maxHeight * 0.5,
                                          width: constraints.maxHeight * 0.95,
                                          fit: BoxFit.fitWidth,
                                          errorListener: (error) =>
                                              Image.asset('assets/default_image.png'),
                                        ),
                                      ),

                                      // Text
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Price: ₹${exploreViewModal.channelData.value.channels![index].price != 0 ? exploreViewModal.channelData.value.channels![index].price : 'Free'}',
                                            style: TextStyle(
                                              color: primaryColor, // Set text color
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                    itemCount: exploreViewModal.channelData.value.channels!.length,
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return const ProgressIndicatorWidget();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProgressIndicatorWidget extends StatelessWidget {
  const ProgressIndicatorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SizedBox(
            height: Get.height * 0.05,
            child: const CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}

