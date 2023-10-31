import 'package:educationadmin/utils/Controllers/UserController.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:carousel_slider/carousel_slider.dart';
class HomeScreen extends StatefulWidget {

   const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 final UserDetailsManager userDetailsManager = Get.find<UserDetailsManager>();

  final InfiniteScrollController infiniteScrollController=InfiniteScrollController();
PageController pageController = PageController(
  initialPage: 1, // Start from the middle item
);
  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF3D5AFE); // Primary Color - Indigo
    const accentColor = Color(0xFFFF8F00); // Accent Color - Amber
    const secondaryColor = Color(0xFF00C853); // Secondary Color - Green
    const textColor = Color(0xFF212121); // Text Color - Black
    const cardBackgroundColor = Color(0xFFE6F0FF); // Light blue gradient background

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
                                  color: textColor,
                                ),
                              ),
                            ),
                            SizedBox(height: Get.height*0.01),
                            Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  size: 12.sp,
                                  color: accentColor,
                                ),
                                const SizedBox(width: 4.0),
                               const Text(
                                  '123K Followers', // Replace with user-related details
                                  style: TextStyle(
                                    color: textColor,
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
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: InkWell(
              onTap: () {
                // Handle Subscribed Channels card tap
              },
              child: Container(
               
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [cardBackgroundColor, Colors.grey[100]!],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Subscribed Channels',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      SizedBox(height: Get.height*0.02),
                      Container(
                         height: Get.height*0.3,
                width: Get.width*0.95,
                child: 
Container(
  height: Get.height*0.3,
  child:   CarouselSlider.builder(
  
    options: CarouselOptions(
  
        height: Get.height*0.25,
  
        aspectRatio: 16/9,
  
        viewportFraction: 0.85,
  
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
  
    itemCount: 15,
  
    itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
  
      Container(
  
        height: Get.height * 0.25,
  
        decoration: const BoxDecoration(
  
          borderRadius: BorderRadius.all(Radius.circular(10)),
  
          image: DecorationImage(
  
            image: NetworkImage('https://via.placeholder.com/400x200'),
  
            fit: BoxFit.cover,
  
          ),
  
          
  
        ),
  
        child: CachedNetworkImage(
  
          colorBlendMode: BlendMode.darken,
  
          imageUrl: 'https://via.placeholder.com/400x200',
  
          placeholder: (context, url) => Image.asset('assets/default_image.png'),
  
          errorWidget: (context, url, error) => Image.asset('assets/default_image.png'),
  
          fit: BoxFit.cover,
  
          errorListener: (error) => Image.asset('assets/default_image.png'),
  
        ),
  
      ),
  
  //                         
  
                        ),
)
                  )],
                  ),
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
                      color: textColor,
                    ),
                  ),
                ),
              ),
                ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: 10,
          itemBuilder: (context, index) {
                return VideoCard(
                  thumbnailUrl: 'https://via.placeholder.com/400x200',
                  title: 'Channel Title $index',
                  channelName: 'Channel Name',
                  viewsCount: '1M Subscribers',
                  duration: '10:00',
                  avatarUrl: 'https://via.placeholder.com/40x40',
                  accentColor: accentColor,
                  gradientStartColor: primaryColor,
                  gradientEndColor: secondaryColor,
                );
          },
                ),
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

class SubscribedChannelCard extends StatelessWidget {
  final String channelName;
  final Color gradientStartColor;
  final Color gradientEndColor;
  final VoidCallback? onTap;

  SubscribedChannelCard({
    required this.channelName,
    required this.gradientStartColor,
    required this.gradientEndColor,
    this.onTap,
  });

   @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Container(
              width: Get.height*0.1,
              height: Get.height*0.1,
              decoration: BoxDecoration(
                shape: BoxShape.circle, // Make it circular
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [gradientStartColor, gradientEndColor],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[300]!,
                    offset:const Offset(0, 2),
                    blurRadius: 3.0,
                  ),
                ],
              ),
              child:const Center(
                child: Icon(
                  Icons.person, // Replace with channel icon or image
                  color: Colors.white,
                  size: 40.0,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              channelName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 10.sp,
                color: Colors.black, // Customize text color here
              ),
            ),
          ],
        ),
      ),
    );
  }


}

class VideoCard extends StatelessWidget {
  final String thumbnailUrl;
  final String title;
  final String channelName;
  final String viewsCount;
  final String duration;
  final String avatarUrl;
  final Color accentColor;
  final Color gradientStartColor;
  final Color gradientEndColor;
  final VoidCallback? onTap;

  VideoCard({
    required this.thumbnailUrl,
    required this.title,
    required this.channelName,
    required this.viewsCount,
    required this.duration,
    required this.avatarUrl,
    required this.accentColor,
    required this.gradientStartColor,
    required this.gradientEndColor,
    this.onTap,
  });

   @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        child: InkWell(
          onTap: onTap,
          child: Container(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(8.0)),
                  child: Image.network(thumbnailUrl, height: 200.0, width: double.infinity, fit: BoxFit.cover),
                ),
               const SizedBox(height: 8.0),
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(avatarUrl),
                  ),
                  title: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(channelName, style:const TextStyle(color: Colors.white)),
                      Row(
                        children: [
                          Text(viewsCount, style:const TextStyle(color: Colors.white)),
                         const SizedBox(width: 8.0),
                          Text(duration, style: const TextStyle(color: Colors.white)),
                        ],
                      ),
                    ],
                  ),
                  trailing: const Icon(Icons.more_vert, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
