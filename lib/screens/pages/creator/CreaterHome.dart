

import 'dart:developer';
import 'package:educationadmin/screens/common/ChannelDetails.dart';
import 'package:educationadmin/screens/pages/creator/EditChannelScreen.dart';
import 'package:logger/logger.dart';
import 'package:educationadmin/screens/pages/Explore2.dart';
import 'package:educationadmin/screens/pages/creator/CreateChannel.dart';
import 'package:educationadmin/screens/pages/creator/CreateChannelsController.dart';
import 'package:educationadmin/screens/pages/creator/CreatorChannel.dart';
import 'package:educationadmin/utils/ColorConstants.dart';
import 'package:educationadmin/utils/Controllers/UserController.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

import '../../../Modals/ChannelListModal.dart';
import '../../../utils/Flag.dart';
import '../../../widgets/ProgressIndicatorWidget.dart';
import '../widgets/VideoCard.dart';

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
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  void onRefresh() async {
   bool result= await createrChannelsController.getChannels();
    setState(() {
isChannelFetched=Future.delayed(Duration.zero,()=>result);
    });
    refreshController.refreshCompleted(); // Complete the refresh
     refreshController.loadComplete();
  }
  @override
  void initState()
  {
    super.initState();
    logger.e("In initState");
    isChannelFetched=createrChannelsController.getChannels();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        floatingActionButton: FloatingActionButton(
          backgroundColor: CustomColors.accentColor,
          foregroundColor: Colors.white,
          onPressed: () {
            Get.to(()=> CreateChannel())!.then((value) => setState((){
              createrChannelsController.getChannels();
            }));
          },
          elevation: 20.0,
          highlightElevation: 50,
          child:const Icon(Icons.add),
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
               SliverAppBar(
                collapsedHeight:   MediaQuery.of(context).size.height * .10,
                expandedHeight:   MediaQuery.of(context).size.height * .10, // Adjust the height as needed
                floating: false,
                pinned: false,
                flexibleSpace:  Container(
                  height:   MediaQuery.of(context).size.height * .10,
                width:   MediaQuery.of(context).size.height * .10, 
                    decoration: const BoxDecoration(
                      color: CustomColors.primaryColorDark
                      // gradient: LinearGradient(
                      //   begin: Alignment.topCenter,
                      //   end: Alignment.bottomCenter,
                      //   colors: [
                      //     Colors.tealAccent,
                      //     Colors.teal
                      //   ], // Light gradient background
                      // ),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: LayoutBuilder(
                      builder: (context, usercardconstra) {
                        return Row(
                          children: [
                            SizedBox(width: Get.width * 0.05),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Your Channels', // Replace with the user's name
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: CustomColors.accentColor
                                  ),
                                ),
                                SizedBox(height: Get.height * 0.01),
                               
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
              )
            ];
          },
          body: SmartRefresher(
            controller: refreshController,
            onRefresh: onRefresh,
            child: ListView(
              children: [
               
                FutureBuilder<bool>(
                  future: isChannelFetched,
                  builder: (context,snapshot) {
                    if(ConnectionState.waiting==snapshot.connectionState)
                    {
                        return const CenterProgressIndicator();
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
                        Obx(
                          ()=> ListView.builder(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: createrChannelsController.channelData.value.channels?.length,
                            itemBuilder: (context, index) {
                              return VideoCard(
                                flag: ListType.Creator,
                                onReturn: ()async{
                                  await  createrChannelsController.getChannels();
                                },
                                channel:createrChannelsController.channelData.value.channels![index],
                                onPressed: () async{
                                        // Handle Delete
                                         // Handle Cancel
                                        CreaterChannelsController controller=Get.put(CreaterChannelsController());
                                  bool result=    await controller.deleteChannel(channelId:createrChannelsController.channelData.value.channels![index].id!);
                                        if(result)
                                        {
                                          Get.back();
                                          Get.showSnackbar(const GetSnackBar(message:'Channel Deleted successfully',duration: Duration(seconds:3),));
                                          
                                          // setState(() {
                                          await  createrChannelsController.getChannels();
                                          // });
                                        }
                                        else{
                                          Get.back();
                                          Get.showSnackbar(const GetSnackBar(message:'Channel could not be deleted successfully',duration: Duration(seconds:3),));
                                        }
                                     
                                     
                                        
                                        // Perform the delete operation
                                        print('Item deleted');
                                      },
                                accentColor: ColorConstants.accentColor,
                                gradientStartColor: ColorConstants.primaryColor,
                                gradientEndColor: ColorConstants.secondaryColor,
                              );
                            },
                          ),
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
                      return const CenterProgressIndicator();
                      
                    }
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CenterProgressIndicator extends StatelessWidget {
  const CenterProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.8,
      child:const Center(
        child:  Padding(
          padding: EdgeInsets.all(8.0),
          child: ProgressIndicatorWidget(),
        ),
      ),
    );
  }
}
