import 'package:cached_network_image/cached_network_image.dart';
import 'package:educationadmin/authentication/viewmodal/ExploreViewModal.dart';
import 'package:educationadmin/utils/Flag.dart';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

import '../../utils/ColorConstants.dart';

import 'widgets/VideoCard.dart';


class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  Future<bool>? isFetched;
  ExploreViewModal exploreViewModal = Get.put(ExploreViewModal());
  final RefreshController refreshController=RefreshController();

void onRefresh() async {
    bool result=await exploreViewModal.getChannels();
    setState(() {
      isFetched=Future.delayed(Duration.zero,()=>result);
    });
    refreshController.refreshCompleted(); // Complete the refresh
     refreshController.loadComplete();
  }
@override
void initState()
{
  isFetched=exploreViewModal.getChannels();
  super.initState();
  
}
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        
        body: SmartRefresher(
          onRefresh: onRefresh,
          controller: refreshController,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
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
                                'Explore Channels', // Replace with the user's name
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
                  color: CustomColors.secondaryColor, // Background color of the bottom sheet
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16.0)),
                 boxShadow: [
                    BoxShadow(
                      color: Colors.grey[300]!,
                      offset: const Offset(0, -2),
                      blurRadius: 3.0,
                    ),
                  ],),
                child: FutureBuilder(
               
                  future: isFetched,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const ProgressIndicatorWidget(),
                      );
                    } else if (snapshot.connectionState == ConnectionState.done) {
                      if (exploreViewModal.channelData.value.channels == null) {
                        return const Center(child: Text('Could not obtain channels'));
                      }
                      
                          return Obx(
                      
                            ()=> ListView.builder(
                            shrinkWrap: true,
                            physics:const ClampingScrollPhysics(),
                            itemCount: exploreViewModal.channelData.value.channels!.length,
                            itemBuilder: (context, index) {
                              return VideoCard(
                                flag:ListType.Explore,
                            onReturn: ()async{
                              //await  createrChannelsController.getChannels();
                            },
                            channel:exploreViewModal.channelData.value.channels![index],
                            onPressed: () async{
                                    // Handle Delete
                                     // Handle Cancel
                              //       CreaterChannelsController controller=Get.put(CreaterChannelsController());
                              // bool result=    await controller.deleteChannel(channelId:createrChannelsController.channelData.value.channels![index].id!);
                              //       if(result)
                              //       {
                                    //   Get.back();
                                    //   Get.showSnackbar(const GetSnackBar(message:'Channel Deleted successfully',duration: Duration(seconds:3),));
                                      
                                    //   // setState(() {
                                    //   await  createrChannelsController.getChannels();
                                    //   // });
                                    // }
                                    // else{
                                    //   Get.back();
                                    //   Get.showSnackbar(const GetSnackBar(message:'Channel could not be deleted successfully',duration: Duration(seconds:3),));
                                    // }
                                 
                                 
                                    
                                    // // Perform the delete operation
                                    // print('Item deleted');
                                  },
                            accentColor: ColorConstants.accentColor,
                            gradientStartColor: ColorConstants.primaryColor,
                            gradientEndColor: ColorConstants.secondaryColor,
                              );
                            },
                            ),
                          );
                        
                        
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      return const Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const ProgressIndicatorWidget(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
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
      child: Center(
        child: SizedBox(
          
          child:  CircularProgressIndicator(color:  
                        Theme.of(context).primaryColorDark,),
        ),
      ),
    );
  }
}

