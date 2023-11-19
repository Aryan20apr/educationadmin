


// import 'package:educationadmin/screens/pages/Explore2.dart';
// import 'package:educationadmin/utils/Controllers/NoticesController.dart';
// import 'package:flutter/material.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';

// import '../../utils/ColorConstants.dart';
// import 'package:sizer/sizer.dart';
// import 'package:get/get.dart';







// class ChatScreen extends StatefulWidget {
//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//  final RefreshController refreshController =
//       RefreshController(initialRefresh: false);
// late Future<bool> isFetched;
// late NoticesController noticesController;
// @override
// void initState()
// {
//   noticesController=Get.put(NoticesController());
//   isFetched=noticesController.getNotices();
//   super.initState();

// }
// void updateMessages()async
// {
//   bool result=await noticesController.getNotices();
//   setState(() {
//     isFetched =Future.delayed(Duration.zero).then((value) => result);
//   });
//   refreshController.refreshCompleted(); // Complete the refresh
//      refreshController.loadComplete();
// }
//   @override
//   Widget build(BuildContext context) {
//     return 
//        SafeArea(
//          child: Scaffold(
//           backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//           appBar: AppBar(
//           backgroundColor: CustomColors.primaryColorDark,
//           foregroundColor: CustomColors.accentColor,
//             title: Text("Notifications",style: TextStyle(fontSize: 14.sp),),
            
//           ),
//           body: SmartRefresher(controller: refreshController,
//           onRefresh: updateMessages,
//           child: FutureBuilder(future: isFetched, builder: (context,snapshot){
//                 if(snapshot.connectionState==ConnectionState.waiting)
//                 {
//                   return const Padding(
//                     padding:  EdgeInsets.all(8.0),
//                     child:  ProgressIndicatorWidget(),
//                   );
//                 }
//                 else if(snapshot.hasError)
//                 {
//                   return const Center(child: Text('Some error occured'));
//                 }
//                 else if(ConnectionState.done==snapshot.connectionState&&snapshot.hasData)
//                 {
//                   if(snapshot.data==false)
//                   {
//                     return const Center(child:Text('Cannot obtain notices'));
//                   }
//                   else
//                   {
//                     //   return ListView.builder(itemCount: noticesController.notices.value.notices!.length,itemBuilder: (context,index){
//                     //   return Card(
//                     //                   color: CustomColors.tileColour,
//                     //                   margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//                     //                   elevation: 4,
//                     //                   child: ListTile(
//                     //                     onTap: () { },
//                     //                     contentPadding: const EdgeInsets.all(10),
                                        
//                     //                     title: Text(
//                     //                       noticesController.notices.value.notices![index].title??"",
//                     //                       style:  TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold,color: CustomColors.secondaryColor),
//                     //                     ),
//                     //                     subtitle: Text(
//                     //                       noticesController.notices.value.notices![index].description??"",
//                     //                       style:  TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold,color: CustomColors.secondaryColor),
//                     //                     ),
//                     //                     // You can display file size or other information here
                                        
//                     //                   ),
//                     //                 );
//                     // });
//                  return   Obx(
//                    ()=> ExpansionPanelList(
//                     elevation: 1,
//                     expandedHeaderPadding: const EdgeInsets.all(10),
//                     expansionCallback: (int index, bool isExpanded) {
//                      noticesController.updateExpansion(index:index,status: isExpanded);
//                     },
//                     children: noticesController.notices.value.notices!
//                         .asMap()
//                         .entries
//                         .map(
//                           (entry) => ExpansionPanel(
//                             headerBuilder:
//                                 (BuildContext context, bool isExpanded) {
//                               return ListTile(
//                                 title: Text(
//                                   entry.value.title ?? "",
//                                   style: TextStyle(
//                                     fontSize: 13.sp,
//                                     fontWeight: FontWeight.bold,
//                                     color: CustomColors.secondaryColor,
//                                   ),
//                                 ),
//                               );
//                             },
//                             body: Card(
//                               color: CustomColors.primaryColorDark,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(10),
//                                 child: Text(
//                                   entry.value.description ?? "",
//                                   style: TextStyle(
//                                     fontSize: 12.sp,
//                                     fontWeight: FontWeight.bold,
//                                     color: CustomColors.secondaryColor,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             isExpanded: noticesController.isExpanded[entry.key], // Set initial expansion state
//                           ),
//                         )
//                         .toList(),
//                                    ),
//                  );
//                   }
//                 }
//                 else
//                 {
//                   return const Center(child: Text('Some error occured'));
//                 }
//           }),
//           )),
//        );
// }
// }
// import 'package:educationadmin/screens/pages/Explore2.dart';
// import 'package:educationadmin/utils/Controllers/NoticesController.dart';
// import 'package:flutter/material.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';

// import '../../utils/ColorConstants.dart';
// import 'package:sizer/sizer.dart';
// import 'package:get/get.dart';

// class ChatScreen extends StatefulWidget {
//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final RefreshController refreshController =
//       RefreshController(initialRefresh: false);
//   late Future<bool> isFetched;
//   late NoticesController noticesController;

//   @override
//   void initState() {
//     noticesController = Get.put(NoticesController());
//     isFetched = noticesController.getNotices();
//     super.initState();
//   }

//   void updateMessages() async {
//     bool result = await noticesController.getNotices();
//     setState(() {
//       isFetched = Future.delayed(Duration.zero).then((value) => result);
//     });
//     refreshController.refreshCompleted();
//     refreshController.loadComplete();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         appBar: AppBar(
//           backgroundColor: CustomColors.primaryColorDark,
//           foregroundColor: CustomColors.accentColor,
//           title: Text(
//             "Notifications",
//             style: TextStyle(fontSize: 14.sp),
//           ),
//         ),
//         body: SmartRefresher(
//           controller: refreshController,
//           onRefresh: updateMessages,
//           enablePullDown: true,
//           child: FutureBuilder(
//             future: isFetched,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: ProgressIndicatorWidget(),
//                 );
//               } else if (snapshot.hasError) {
//                 return const Center(child: Text('Some error occurred'));
//               } else if (ConnectionState.done == snapshot.connectionState &&
//                   snapshot.hasData) {
//                 if (snapshot.data == false) {
//                   return const Center(child: Text('Cannot obtain notices'));
//                 } else {
//                   return CustomScrollView(
//                     physics: const NeverScrollableScrollPhysics(),
//                     slivers: [
//                       SliverList(
//                         delegate: SliverChildBuilderDelegate(
//                           (BuildContext context, int index) {
//                             return Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: ExpansionTile(
//                                 shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
//                                 collapsedShape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
//                                 backgroundColor: CustomColors.primaryColorDark,
//                                 collapsedBackgroundColor: CustomColors.primaryColorDark,
//                                 collapsedIconColor: CustomColors.accentColor,
//                                 iconColor: CustomColors.accentColor,
//                                 title: Text(
//                                   noticesController
//                                           .notices.value.notices![index].title ??
//                                       "",
//                                   style: TextStyle(
//                                     fontSize: 13.sp,
//                                     fontWeight: FontWeight.bold,
//                                     color: CustomColors.accentColor,
//                                   ),
//                                 ),
//                                 children: [
//                                   Card(
                                    
//                                     color: CustomColors.primaryColorDark,
//                                     child: LayoutBuilder(
//                                       builder: (context,constraints) {
//                                         return Container(
//                                           width: constraints.maxWidth*0.95,
//                                           decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,),
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: Text(
//                                               '${noticesController.notices.value.notices![index]
//                                                       .description} qdwfessvsrvsevwqfecsbtdebehehryjnryrdbdbdtenedtnnreyntenreeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeedfbdfbdberbtebrnyrnyrnetwgrwqge4grehbtdn'??
//                                                   "",
//                                               style: TextStyle(
//                                                 fontSize: 13.sp,
//                                                 fontWeight: FontWeight.w500,
//                                                 color: Colors.black,
//                                               ),
//                                             ),
//                                           ),
//                                         );
//                                       }
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                           childCount: noticesController.notices.value.notices!.length,
//                         ),
//                       ),
//                     ],
//                   );
//                 }
//               } else {
//                 return const Center(child: Text('Some error occurred'));
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:educationadmin/screens/pages/Explore2.dart';
import 'package:educationadmin/utils/Controllers/NoticesController.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../utils/ColorConstants.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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
        // appBar: AppBar(
        //   backgroundColor: CustomColors.primaryColorDark,
        //   foregroundColor: CustomColors.accentColor,
        //   title: Text(
        //     "Notifications",
        //     style: TextStyle(fontSize: 14.sp),
        //   ),
        // ),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
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
                                  'Notifications', // Replace with the user's name
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
            onRefresh: updateMessages,
            enablePullDown: true,
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
                                      return CustomScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    slivers: [
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ExpansionTile(
                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                collapsedShape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                backgroundColor: CustomColors.primaryColorDark,
                                collapsedBackgroundColor: CustomColors.primaryColorDark,
                                collapsedIconColor: CustomColors.accentColor,
                                iconColor: CustomColors.accentColor,
                                title: Text(
                                  noticesController
                                          .notices.value.notices![index].title ??
                                      "",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                    color: CustomColors.accentColor,
                                  ),
                                ),
                                children: [
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
                                                      .description} qdwfessvsrvsevwqfecsbtdebehehryjnryrdbdbdtenedtnnreyntenreeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeedfbdfbdberbtebrnyrnyrnetwgrwqge4grehbtdn'??
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
                                ],
                              ),
                            );
                          },
                          childCount: noticesController.notices.value.notices!.length,
                        ),
                      ),
                    ],
                  );

                  }
                } else {
                  return const Center(child: Text('Some error occurred'));
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
