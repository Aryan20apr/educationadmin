

import 'package:educationadmin/screens/pages/Explore2.dart';
import 'package:educationadmin/utils/Controllers/NoticesController.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../utils/ColorConstants.dart';

import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import '../../../widgets/ProgressIndicatorWidget.dart';

class CreatorNotifications extends StatefulWidget {
  const CreatorNotifications({super.key});

  @override
  State<CreatorNotifications> createState() => _CreatorNotificationsState();
}

class _CreatorNotificationsState extends State<CreatorNotifications> {
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  late Future<bool> isFetched;
  late NoticesController noticesController;

  @override
  void initState() {
    noticesController = Get.put(NoticesController());
    isFetched = noticesController.getNotices();
    super.initState();
  }

  void updateMessages() async {
    bool result = await noticesController.getNotices();
    setState(() {
      isFetched = Future.delayed(Duration.zero).then((value) => result);
    });
    refreshController.refreshCompleted();
    refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: CustomColors.primaryColorDark,
          foregroundColor: CustomColors.accentColor,
          title: Text(
            "Notifications",
            style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold),
          ),
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              // SliverAppBar(
              //   collapsedHeight:   MediaQuery.of(context).size.height * .10,
              //   expandedHeight:   MediaQuery.of(context).size.height * .10, // Adjust the height as needed
              //   floating: false,
              //   pinned: false,
              //   flexibleSpace:  Container(
              //     height:   MediaQuery.of(context).size.height * .10,
              //   width:   MediaQuery.of(context).size.height * .10, 
              //       decoration: const BoxDecoration(
              //         color: CustomColors.primaryColorDark
              //         // gradient: LinearGradient(
              //         //   begin: Alignment.topCenter,
              //         //   end: Alignment.bottomCenter,
              //         //   colors: [
              //         //     Colors.tealAccent,
              //         //     Colors.teal
              //         //   ], // Light gradient background
              //         // ),
              //       ),
              //       padding: const EdgeInsets.all(16.0),
              //       child: LayoutBuilder(
              //         builder: (context, usercardconstra) {
              //           return Row(
              //             children: [
              //               SizedBox(width: Get.width * 0.05),
              //               Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 children: [
              //                   Text(
              //                     'Notifications', // Replace with the user's name
              //                     style: TextStyle(
              //                       fontSize: 18.sp,
              //                       fontWeight: FontWeight.bold,
              //                       color: CustomColors.accentColor
              //                     ),
              //                   ),
              //                   SizedBox(height: Get.height * 0.01),
                               
              //                 ],
              //               ),
              //             ],
              //           );
              //         },
              //       ),
              //     ),
              // )
            ];
          },
          body: SmartRefresher(
            controller: refreshController,
            onRefresh: updateMessages,
            enablePullDown: true,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children:[ Container(
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
                        padding: EdgeInsets.all(8.0),
                        child: ProgressIndicatorWidget(),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(child: Text('Some error occurred'));
                    } else if (ConnectionState.done == snapshot.connectionState &&
                        snapshot.hasData) {
                      if (snapshot.data == false) {
                        return const Center(child: Text('Cannot obtain notices'));
                      } else {
                                         
                        //physics: const NeverScrollableScrollPhysics(),
                       if(noticesController.notices.value.notices!.isNotEmpty) {
                         return  Obx(
                         ()=> ListView.builder(
                          shrinkWrap: true,
                          physics:const ClampingScrollPhysics(),
                              itemBuilder: 
                                (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        decoration: BoxDecoration(
                                          color: CustomColors.primaryColorDark,
                                          borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left:18.0,right: 8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween
                                                ,children: <Widget>[
                                            Text(
                                                                                    noticesController
                                                    .notices.value.notices![index].title ??
                                                "",
                                                                                    style: TextStyle(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.bold,
                                              color: CustomColors.accentColor,
                                                                                    ),
                                                                                  ),
                                                                                  IconButton(onPressed: (){
                                                                                    noticesController.deleteNotice(id:noticesController.notices.value.notices![index].id!,index: index);
                                                                                   
                                                                                  }, icon: const Icon(Icons.delete,color: CustomColors.accentColor,))
                                                                                    ],
                                                                                    
                                                                                  ),
                                            ),
                                        Card(
                                            
                                            color: CustomColors.primaryColorDark,
                                            child: LayoutBuilder(
                                              builder: (context,constraints) {
                                                return Container(
                                                  width: constraints.maxWidth*0.95,
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(
                                                      '${noticesController.notices.value.notices![index]
                                                              .description}'??
                                                          "",
                                                      style: TextStyle(
                                                        fontSize: 13.sp,
                                                        fontWeight: FontWeight.w500,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }
                                            ),
                                          ),
                                        ]
                                        ,
                                      )
                                    ),
                                  );
                                },
                                itemCount: noticesController.notices.value.notices!.length,
                              
                            ),
                       );
                       }
                       else
                       {
                        return Center(child: Column(
                          children: [
                            SizedBox(height: Get.height*0.4,),
                            Padding(padding: EdgeInsets.all(10),child: Text('No notification available',style: TextStyle(fontSize: 12.sp),),),
                          ],
                        ));
                       }
                        
                      
                
                      }
                    } else {
                      return const Center(child: Text('Some error occurred'));
                    }
                  },
                ),
              ),
              ]
            ),
          ),
        ),
      ),
    );
  }
}
