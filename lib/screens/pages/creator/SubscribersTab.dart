import 'dart:developer';

import 'package:educationadmin/Modals/SubsciberModal.dart';
import 'package:educationadmin/screens/pages/Explore2.dart';
import 'package:educationadmin/screens/pages/creator/CreateChannelsController.dart';
import 'package:educationadmin/utils/ColorConstants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../widgets/ProgressIndicatorWidget.dart';
class SubscribersTab extends StatefulWidget {
   const SubscribersTab({
    super.key,
    required this.channelId,
    required this.createrId
  });
 final int channelId;
 final int createrId;

  @override
  State<SubscribersTab> createState() => _SubscribersTabState();
}

class _SubscribersTabState extends State<SubscribersTab> {
  late Future<bool> consumers;
  CreaterChannelsController controller=Get.put(CreaterChannelsController());
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
      ScrollController scrollController=ScrollController();
  Future<bool>? isFetched;
List<Consumers> subscribers=[];
void onRefresh() async {
   bool result= await controller.getChannelSubscribers
    (channelId: widget.channelId);
    setState(() {
      subscribers=controller.consumerList.value.consumers??[];
      isFetched=Future.delayed(Duration.zero,()=>result);
    });
    _refreshController.refreshCompleted(); // Complete the refresh
     _refreshController.loadComplete();
  }
  @override
  void initState()
  {
    super.initState();
    consumers=controller.getChannelSubscribers(channelId: widget.channelId);
     scrollController.addListener(_scrollListener);
  }
  @override
  void dispose() {
    scrollController.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (scrollController.offset <= scrollController.position.minScrollExtent &&
        !_refreshController.isRefresh) {
      // User has reached the top, and not currently refreshing
      _refreshController.requestRefresh();
    }
  }
   
  @override
  Widget build(BuildContext context) {
    return NotificationListener(
       onNotification: (ScrollNotification scrollInfo) {
         scrollController.position.copyWith();
        return false;
      },

      child: SmartRefresher(
        onRefresh: onRefresh,
        controller: _refreshController,
        child: FutureBuilder<bool>(
          future:consumers,
          builder: (context,snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting)
            {
              return const ProgressIndicatorWidget();
            }
            else if(snapshot.hasError)
            {
              return const Center(child:Text('Some error occured'));
            }
            else if(ConnectionState.done==snapshot.connectionState)
            {
              if(snapshot.hasData&&snapshot.data==false) {
                return const Center(child: Text("No subscribers"));
              }
              else {
                if(controller.consumerList.value.consumers!.isEmpty) {
                  return const Center(child: Text("No subscribers"));
                } else {
    
                  return Obx(
                    ()=> ListView.builder(
                      controller: scrollController,
                      shrinkWrap: true,
                      physics:const BouncingScrollPhysics(),
                                itemCount: controller.consumerList.value.consumers!.length, // Adjust the number of subscribers
                              
                                itemBuilder: (context, index) {
                    return Card(
                      color: CustomColors.tileColour,
                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      elevation: 4,
                      child: ListTile(
                        onTap: () {},
                        contentPadding: const EdgeInsets.all(10),
                        leading:  ClipOval(
                          child: CircleAvatar(
                            radius: 28, // Adjust the radius as needed
                                  
                            child: CachedNetworkImage(
                              height: double.infinity,
                              width: double.infinity,
                                      colorBlendMode: BlendMode.darken,
                                                      imageUrl: controller.consumerList.value.consumers![index].image??'',
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
                          '${controller.consumerList.value.consumers![index].name}',
                          style:  TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold,color: CustomColors.accentColor),
                        ),
                        subtitle:Text(
                          '${controller.consumerList.value.consumers![index].phone}',
                          style:  TextStyle(fontSize: 12.sp, color: CustomColors.secondaryColor),
                        
                        ) ,
                        trailing: PopupMenuButton<String>(
                          icon: const Icon(Icons.more_vert, color: CustomColors.secondaryColor), // Icon color is green
                          itemBuilder: (context) {
                            return <PopupMenuEntry<String>>[
                              
                              const PopupMenuItem<String>(
                                value: 'delete',
                                child: Row(
                    children: <Widget>[
                      Icon(Icons.delete, color: CustomColors.primaryColorDark), // Delete icon is green
                      SizedBox(width: 8),
                      Text('Remove Subscriber', style: TextStyle(color: CustomColors.primaryColorDark)),
                    ],
                                ),
                              ),
                            ];
                          },
                          onSelected: (value) {
                             if (value == 'delete') {
                              // Handle Delete option
                            log('Delete selected');
                              _showDeleteConfirmationDialog(context,index);
                            }
                          },
                        ),
                      ),
                    );
                                },
                              ),
                  );
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
    );
  }

Future<void> _showDeleteConfirmationDialog(BuildContext context,int index) async{
   await showDialog(
      
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          
          title: const Text('Delete Confirmation'),
          content: const Text('Are you sure you want to remove this subscriber?'),
          actions: <Widget>[
          
            Obx(
              ()=> Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                   backgroundColor: CustomColors.primaryColor,foregroundColor: Colors.white,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    fixedSize: Size(Get.width*0.6, Get.height*0.06)
                  ),
                
                  onPressed:() async{
                                     controller.isLoading.value=false;
                  controller.removeSubscriber(channeId: widget.channelId,index:index);
                                    },
                  child:controller.isLoading.value==false?  Text(
                    'Delete',
                    style: TextStyle(color: Colors.white,fontSize:10.sp),
                  ):const ProgressIndicatorWidget(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
