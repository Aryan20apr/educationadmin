import 'package:cached_network_image/cached_network_image.dart';
import 'package:talentsearchenglish/authentication/viewmodal/ExploreViewModal.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sizer/sizer.dart';

import '../common/ChannelDetails.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  ExploreViewModal exploreViewModal = Get.put(ExploreViewModal());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            centerTitle: false,
            expandedHeight: Get.height * 0.1,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              title: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Explore Courses',
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              centerTitle: true,
            ),
          ),
          SliverFillRemaining(
            child: FutureBuilder(
                future: exploreViewModal.getChannels(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                            child: SizedBox(
                                height: Get.height * 0.05,
                                child: const CircularProgressIndicator())),
                      ),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (exploreViewModal.channelData.value.channels == null) {
                      return const Center(
                          child: Text('Could not obtain channels'));
                    }
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: Get.height * 0.6,
                          width: Get.width * 0.95,
                          child: LayoutBuilder(builder: (context, constraints) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Material(
                                elevation: 20.0,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                child: InkWell(
                                  onTap: () {
                                    Get.to(() => ChannelDetails(
                                          channel: exploreViewModal.channelData
                                              .value.channels![index],
                                        ));
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0))),
                                    margin: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        // Title and subtitle
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  '${exploreViewModal.channelData.value.channels![index].name}',
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                'Created by ${exploreViewModal.channelData.value.channels![index].createdBy}',
                                              ),
                                            ],
                                          ),
                                        ),

                                        // Network image
                                        CachedNetworkImage(
                                          imageUrl:
                                              '${exploreViewModal.channelData.value.channels![index].thumbnail}',
                                          placeholder: (context, url) =>
                                              Image.asset(
                                                  'assets/default_image.png'),
                                          errorWidget: (context, url, error) =>
                                              Image.asset(
                                                  'assets/default_image.png'),
                                          height: constraints.maxHeight * 0.5,
                                          width: constraints.maxHeight * 0.95,
                                          fit: BoxFit.fitWidth,
                                          errorListener: (error) => Image.asset(
                                              'assets/default_image.png'),
                                        ),

                                        //  Image.network(

                                        //         '${exploreViewModal.channelData.value.channels![index].thumbnail}',
                                        //         height: constraints.maxHeight*0.5,
                                        //         width: constraints.maxHeight*0.95,
                                        //         fit: BoxFit.fitWidth,

                                        //       ) ,

                                        // Text
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Text(
                                            'Price: ${exploreViewModal.channelData.value.channels![index].price != 0 ? exploreViewModal.channelData.value.channels![index].price : 'Free'}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15.sp),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        );
                      },
                      itemCount:
                          exploreViewModal.channelData.value.channels!.length,
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                            child: SizedBox(
                                height: Get.height * 0.05,
                                child: const CircularProgressIndicator())),
                      ),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}
