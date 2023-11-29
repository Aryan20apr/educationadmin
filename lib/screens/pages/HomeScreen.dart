

import 'package:educationadmin/screens/pages/Explore2.dart';
import 'package:educationadmin/screens/pages/widgets/DefaultCarousel.dart';
import 'package:educationadmin/utils/Controllers/HomeScreenController.dart';
import 'package:educationadmin/utils/Controllers/UserController.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:educationadmin/utils/ColorConstants.dart';
import 'package:educationadmin/Modals/BannersResponse.dart';
import '../../widgets/ProgressIndicatorWidget.dart';
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
final CarouselController _carouselController = CarouselController();
Future<bool>? isFetchedUser;
Future<bool>? isBannersFetched;
  
PageController pageController = PageController(
  initialPage: 1, // Start from the middle item
);
final RefreshController refreshController =
      RefreshController(initialRefresh: false);
void onRefresh() async {
  bool userChannels= await  homeScreenController.getChannels();
 bool banners= await homeScreenController.getBanners();
    setState(() {
      isBannersFetched=Future.delayed(Duration.zero,()=>banners);
      isFetchedUser=Future.delayed(Duration.zero,()=>userChannels);
    });
    refreshController.refreshCompleted(); // Complete the refresh
     refreshController.loadComplete();
  }
@override
void initState()
{
  super.initState();
  isFetchedUser=homeScreenController.getChannels();
  isBannersFetched=homeScreenController.getBanners();
}

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: NestedScrollView(
         headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                collapsedHeight:   MediaQuery.of(context).size.height * .15,
                expandedHeight:   MediaQuery.of(context).size.height * .15, // Adjust the height as needed
                floating: false,
                pinned: false,
                flexibleSpace: Container(
              height: MediaQuery.of(context).size.height * .15,
              width: MediaQuery.of(context).size.width,
              decoration:const BoxDecoration(
                color: CustomColors.primaryColorDark
                // gradient: LinearGradient(
                //   begin: Alignment.topCenter,
                //   end: Alignment.bottomCenter,
                //   colors: [Colors.tealAccent,Colors.teal ], // Light gradient background
                // ),
              ),
              padding: const EdgeInsets.all(16.0),
              child: LayoutBuilder(
                builder: (context,usercardconstra) {
                  return Obx(
                    ()=> Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: CircleAvatar(
                            radius: Get.width*0.1,
                            // backgroundImage:const NetworkImage(
                            //     'https://via.placeholder.com/100x100'),
                            child:CachedNetworkImage(
                              width: double.infinity,
                              height: double.infinity,
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(
                              ()=> Text(
                                '${userDetailsManager.username}', // Replace with the user's name
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  color: CustomColors.accentColor,
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
                                    color: CustomColors.accentColor,
                                    fontSize: 12.sp
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
                )];
              
            
          },
         body:
            
            SmartRefresher(
              onRefresh:onRefresh ,
              controller: refreshController,
              child: ListView(
                //physics:const NeverScrollableScrollPhysics(),
                children: [
                  
                  Card(
                    elevation: 4.0,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
                    child: Container(
                     
                      decoration: const BoxDecoration(
                        color: CustomColors.secondaryColor,
                        // gradient: LinearGradient(
                        //   begin: Alignment.centerLeft,
                        //   end: Alignment.centerRight,
                        //   colors: [ColorConstants.cardBackgroundColor, Colors.grey[100]!],
                        // ),
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
              future: isBannersFetched,
              builder: (context,snapshot) {
               if(snapshot.connectionState==ConnectionState.waiting)
               {
                return const DefaultCarousel();
               }
               else
               {
                if(snapshot.data==true) {
                 
                 if(snapshot.data==false)
                          
                 {
               return const DefaultCarousel();
                 }
                 else
              {
                if(homeScreenController.bannersList.value.banners!.length==0) {
                  return const DefaultCarousel();
                } else {
                  return Column(
                children: [
                  CarouselSlider.builder(
                   carouselController: _carouselController, 
                  options: CarouselOptions(
                    
                      clipBehavior: Clip.antiAlias,
                    
                      aspectRatio: 16/9,
                    
                      viewportFraction: 0.75,
                    
                      initialPage: 0,
                    
                      enableInfiniteScroll: true,
                    
                      reverse: false,
                    
                      autoPlay: true,
                    
                      autoPlayInterval: const Duration(seconds: 3),
                    
                      autoPlayAnimationDuration: const Duration(milliseconds: 800),
                    
                      autoPlayCurve: Curves.fastOutSlowIn,
                    
                      enlargeCenterPage: true,
                    
                      enlargeFactor: 0.3,

                      onPageChanged: (index,reason){
                        homeScreenController.currentPage.value=index;
                      },
                     //
                    
                      scrollDirection: Axis.horizontal,
                    
                   ),
                    
                  itemCount: homeScreenController.bannersList.value.banners!.length,
                    
                  itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                    
                    ClipRRect(
                       borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                           border: Border.all(
                        color: Theme.of(context).primaryColorDark, // Set the border color to black
                        width: 4.0, // Adjust the border width as needed
                      ),
                        ),
                        child: CachedNetworkImage(
                          width: double.infinity,
                        colorBlendMode: BlendMode.darken,
                          
                        imageUrl: homeScreenController.bannersList.value.banners![itemIndex].image!,
                          
                        placeholder: (context, url) => Image.asset('assets/default_image.png'),
                          
                        errorWidget: (context, url, error) => Image.asset('assets/default_image.png'),
                          
                        fit: BoxFit.cover,
                          
                        errorListener: (error) => Image.asset('assets/default_image.png'),
                          
                        ),
                      ),
                    ),
                    
                    //                         
                    
                                    ),
                  Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: List.generate(
    homeScreenController.bannersList.value.banners!.length,
    (index) {
      return GestureDetector(
        onTap: () {
          homeScreenController.currentPage.value=index;
          _carouselController.animateToPage(index); // Change the current image
        },
        child: Obx(
          ()=> Padding(
            padding: const EdgeInsets.only(top:8.0),
            child: Container(
              width: 8.0, // Adjust the width of the indicator
              height: 8.0, // Adjust the height of the indicator
              margin: const EdgeInsets.symmetric(horizontal: 4.0), // Adjust the margin
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: index == homeScreenController.currentPage.value
                    ? CustomColors.primaryColorDark // Active indicator color
                    : Colors.grey, // Inactive indicator color
              ),
            ),
          ),
        ),
          );
    },
                     )
      
                  )
                ],
                
              );
                }}
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
                     color: Theme.of(context).scaffoldBackgroundColor,
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
                              return const Center(child: ProgressIndicatorWidget());
                            }
                            
                            else if(snapshot.hasData){
                              if(snapshot.data==false)
                              {
                                  return const Center(child: Text('Could not obtain channels for you'),);
                              }
                              else
                              {
                                if(homeScreenController.channelData.value.channels!.isEmpty)
                                {
                                  return SizedBox(
                                    height: Get.height*0.1,
                                    child: const Center(child: Text('Youi have not subscribed to any channels.'),));
                                }
                              
                              return ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: homeScreenController.channelData.value.channels!.length,
                  itemBuilder: (context, index) {
                            return HomeVideoCard(
                              onTap: (){
                   
                      Get.to(() => ChannelDetails(
                                                      channel:
                                                          homeScreenController
                                                              .channelData
                                                              .value
                                                              .channels![index],
                                                    ));
                      // print(homeScreenController
                      //                                 .channelData
                      //                                 .value
                      //                                 .channels![index]
                      //                                 .isCompletelyPaid!);
                      //                                 print(homeScreenController
                      //                                 .channelData
                      //                                 .value
                      //                                 .channels![index]
                      //                                 .price);
                      //                         if (homeScreenController
                      //                                 .channelData
                      //                                 .value
                      //                                 .channels![index]
                      //                                 .isCompletelyPaid! ||
                      //                             homeScreenController
                      //                                     .channelData
                      //                                     .value
                      //                                     .channels![index]
                      //                                     .price ==
                      //                                 0) {
                      //                           Get.to(() => ChannelDetails(
                      //                                 channel:
                      //                                     homeScreenController
                      //                                         .channelData
                      //                                         .value
                      //                                         .channels![index],
                      //                               ));
                      //                         } else {
                      //                           Get.defaultDialog(
                      //                             title: 'Attention',
                      //                             backgroundColor: CustomColors
                      //                                 .secondaryColor,
                      //                             middleText:
                      //                                 'This content is not available free of cost.',
                      //                             //textConfirm: 'This content is not available free of cost',
                      //                             confirmTextColor:
                      //                                 Colors.white,
                      //                             confirm: ElevatedButton(
                      //                                 onPressed: () {
                      //                                   Get.back();
                      //                                 },
                      //                                 style: ElevatedButton.styleFrom(
                      //                                     backgroundColor:
                      //                                         CustomColors
                      //                                             .primaryColor,
                      //                                     foregroundColor:
                      //                                         CustomColors
                      //                                             .secondaryColor),
                      //                                 child: const Text('Ok')),
                      //                           );
                      //                         }
                                            },
                              
                              thumbnailUrl: homeScreenController.channelData.value.channels![index].thumbnail!,
                              title: homeScreenController.channelData.value.channels![index].name!,
                              price: homeScreenController.channelData.value.channels![index].price??0,
                              avatarUrl: 'https://via.placeholder.com/40x40',
                              accentColor:  ColorConstants.accentColor,
                              gradientStartColor: ColorConstants.primaryColor,
                              gradientEndColor: ColorConstants.secondaryColor,
                            );
                            }
                              );
                              
                            
                          }
                            
                            }
                            else
                            {
                               return const Center(child: Text('Could not obtain channels for you'),);
                            }
                          }
                        )
                  
                      ],
                    ),
                  ),
                ],
              ),
            ),
          
        ),
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





