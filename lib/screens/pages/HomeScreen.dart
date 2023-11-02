import 'dart:ffi';

import 'package:educationadmin/screens/pages/Explore2.dart';
import 'package:educationadmin/screens/pages/widgets/DefaultCarousel.dart';
import 'package:educationadmin/utils/Controllers/HomeScreenController.dart';
import 'package:educationadmin/utils/Controllers/UserController.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:educationadmin/utils/ColorConstants.dart';
import '../common/ChannelDetails.dart';
import 'widgets/HomeVideoCard.dart';
class HomeScreen extends StatefulWidget {

   const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 final UserDetailsManager userDetailsManager = Get.find<UserDetailsManager>();
final HomeScreenController homeScreenController=Get.put(HomeScreenController());

Future<bool>? isFetchedUser;
Future<bool>? isFetchedAll;
  final InfiniteScrollController infiniteScrollController=InfiniteScrollController();
PageController pageController = PageController(
  initialPage: 1, // Start from the middle item
);
@override
void initState()
{
  super.initState();
  isFetchedUser=homeScreenController.getChannels();
  isFetchedAll=homeScreenController.getAllChannels();
}

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: ListView(
        children: [
          InkWell(
            onTap: () {
              // Handle user profile tap
            },
            child: Container(
              decoration:const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.tealAccent,Colors.teal ], // Light gradient background
                ),
              ),
              padding: const EdgeInsets.all(16.0),
              child: LayoutBuilder(
                builder: (context,usercardconstra) {
                  return Obx(
                    ()=> Row(
                      children: [
                        ClipOval(
                          child: CircleAvatar(
                            radius: Get.width*0.1,
                            // backgroundImage:const NetworkImage(
                            //     'https://via.placeholder.com/100x100'),
                            child:CachedNetworkImage(
                              colorBlendMode: BlendMode.darken,
                                              imageUrl: userDetailsManager.image.value,
                            placeholder: (context, url) => Image.asset(
                              'assets/default_image.png',
                              fit: BoxFit.fill,
                              width: Get.width * 0.1 * 2, // Set the width to match the diameter of the CircleAvatar
                              height: Get.width * 0.1 * 2, // Set the height to match the diameter of the CircleAvatar
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              'assets/default_image.png',
                              fit: BoxFit.fill,
                              width: Get.width * 0.1 * 2, // Set the width to match the diameter of the CircleAvatar
                              height: Get.width * 0.1 * 2, // Set the height to match the diameter of the CircleAvatar
                            ),
                            fit: BoxFit.cover,
                                            ), // Replace with the user's image URL
                          ),
                        ),
                        SizedBox(width: Get.width*0.05),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(
                              ()=> Text(
                                '${userDetailsManager.username}', // Replace with the user's name
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: ColorConstants.textColor,
                                ),
                              ),
                            ),
                            SizedBox(height: Get.height*0.01),
                            Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  size: 12.sp,
                                  color: ColorConstants.accentColor,
                                ),
                                const SizedBox(width: 4.0),
                               Text(
                                  '123K Followers', // Replace with user-related details
                                  style: TextStyle(
                                    color: ColorConstants.textColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }
              ),
            ),
          ),
          Card(
            elevation: 4.0,
            margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
            child: Container(
             
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [ColorConstants.cardBackgroundColor, Colors.grey[100]!],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Trending',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.textColor,
                      ),
                    ),
                    SizedBox(height: Get.height*0.02),
                    Container(
                     
              child: 
FutureBuilder<bool>(
  future: isFetchedAll,
  builder: (context,snapshot) {
   if(snapshot.connectionState==ConnectionState.waiting)
   {
    return const DefaultCarousel();
   }
   else
   {
    if(snapshot.data==true) {
      return CarouselSlider.builder(
    
      options: CarouselOptions(
    
          clipBehavior: Clip.antiAlias,
    
          aspectRatio: 16/9,
    
          viewportFraction: 0.95,
    
          initialPage: 0,
    
          enableInfiniteScroll: true,
    
          reverse: false,
    
          autoPlay: true,
    
          autoPlayInterval: const Duration(seconds: 3),
    
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
    
          autoPlayCurve: Curves.fastOutSlowIn,
    
          enlargeCenterPage: true,
    
          enlargeFactor: 0.3,
    
         //
    
          scrollDirection: Axis.horizontal,
    
       ),
    
      itemCount: homeScreenController.allChannelData.value.channels!.length,
    
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
    
        InkWell(
          onTap: (){
           Get.to(()=>ChannelDetails(channel: 
               homeScreenController.allChannelData.value.channels![itemIndex],
          ));
          },
          child: ClipRRect(
             borderRadius: BorderRadius.circular(10.0),
            child: CachedNetworkImage(
              width: double.infinity,
            colorBlendMode: BlendMode.darken,
              
            imageUrl: homeScreenController.allChannelData.value.channels![itemIndex].thumbnail!,
              
            placeholder: (context, url) => Image.asset('assets/default_image.png'),
              
            errorWidget: (context, url, error) => Image.asset('assets/default_image.png'),
              
            fit: BoxFit.cover,
              
            errorListener: (error) => Image.asset('assets/default_image.png'),
              
            ),
          ),
        ),
    
    //                         
    
                        );
    }
    else
    {
      return const DefaultCarousel();
    }
    }
    
    
  }
)
                )],
                ),
              ),
            ),
          ),
          Container(
            
            decoration: BoxDecoration(
              color: Colors.white, // Background color of the bottom sheet
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[300]!,
                  offset: const Offset(0, -2),
                  blurRadius: 3.0,
                ),
              ],
            ),
            child: Column(
              children: [
                Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    
                    'For You',
                     // Add the "For You" heading
                    style: TextStyle(
                      
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.textColor,
                    ),
                  ),
                ),
              ),
                FutureBuilder<bool>(
                  future:isFetchedUser,
                  builder: (context,snapshot) {
                    if(snapshot.connectionState==ConnectionState.waiting)
                    {
                      return const ProgressIndicatorWidget();
                    }
                    
                    else {
                      if(snapshot.data==false)
                      {
                          return const Center(child: Text('Could not obtain channels for you'),);
                      }
                      else
                      {return ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: homeScreenController.channelData.value.channels!.length,
          itemBuilder: (context, index) {
                    return HomeVideoCard(
                      onTap: (){
                        Get.to(()=>ChannelDetails(channel: 
                     homeScreenController.channelData.value.channels![index],
              ));
                      },
                      thumbnailUrl: homeScreenController.channelData.value.channels![index].thumbnail!,
                      title: homeScreenController.channelData.value.channels![index].name!,
                      channelName: 'Channel Name',
                      viewsCount: '1M Subscribers',
                      duration: '10:00',
                      avatarUrl: 'https://via.placeholder.com/40x40',
                      accentColor:  ColorConstants.accentColor,
                      gradientStartColor: ColorConstants.primaryColor,
                      gradientEndColor: ColorConstants.secondaryColor,
                    );
                    }
                      );
                      
                    
                  }
                    
                    }
                  }
                )

              ],
            ),
          ),
        ],
      ),
    );
  }
  double calculateElevation(double position) {
  const maxElevation = 1.0; // Maximum elevation
  const minElevation = 0.0; // Minimum elevation
  const elevationFactor = 0.02; // Adjust this factor to control the rate of elevation change

  final elevation = maxElevation - (position.abs() * elevationFactor);
  return elevation.clamp(minElevation, maxElevation);
}
}



// class SubscribedChannelCard extends StatelessWidget {
//   final String channelName;
//   final Color gradientStartColor;
//   final Color gradientEndColor;
//   final VoidCallback? onTap;

//   SubscribedChannelCard({
//     required this.channelName,
//     required this.gradientStartColor,
//     required this.gradientEndColor,
//     this.onTap,
//   });

//    @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
        
//         margin: const EdgeInsets.symmetric(horizontal: 8.0),
//         child: Column(
//           children: [
//             Container(
//               width: Get.height*0.1,
//               height: Get.height*0.1,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle, // Make it circular
//                 gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: [gradientStartColor, gradientEndColor],
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey[300]!,
//                     offset:const Offset(0, 2),
//                     blurRadius: 3.0,
//                   ),
//                 ],
//               ),
//               child:const Center(
//                 child: Icon(
//                   Icons.person, // Replace with channel icon or image
//                   color: Colors.white,
//                   size: 40.0,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 8.0),
//             Text(
//               channelName,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 10.sp,
//                 color: Colors.black, // Customize text color here
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }


// }

