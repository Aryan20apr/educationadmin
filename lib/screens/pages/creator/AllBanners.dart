

import 'package:educationadmin/screens/pages/Explore2.dart';
import 'package:educationadmin/utils/Controllers/BannerController.dart';
import 'package:educationadmin/utils/Controllers/NoticesController.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../utils/ColorConstants.dart';

import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import '../../../widgets/ProgressIndicatorWidget.dart';

class MyBanners extends StatefulWidget {
  @override
  State<MyBanners> createState() => _MyBannersState();
}

class _MyBannersState extends State<MyBanners> {
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  late Future<bool> isFetched;
  late BannerController bannerController;

  @override
  void initState() {
    bannerController = Get.put(BannerController());
    isFetched = bannerController.getBanners();
    super.initState();
  }

  void updateMessages() async {
    bool result = await bannerController.getBanners();
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
            "My Banners",
            style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold),
          ),
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
           
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
                       if(bannerController.bannersList.value.banners!.isNotEmpty) {
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
                                          color: Colors.grey.shade300,
                                          borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: Column(
                                          children: [
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
                          
                        imageUrl: bannerController.bannersList.value.banners![index].image!,
                          
                        placeholder: (context, url) => Image.asset('assets/default_image.png'),
                          
                        errorWidget: (context, url, error) => Image.asset('assets/default_image.png'),
                          
                        fit: BoxFit.cover,
                          
                        errorListener: (error) => Image.asset('assets/default_image.png'),
                          
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical:4),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),backgroundColor: CustomColors.primaryColor,foregroundColor: Colors.white,elevation: 4,)
                        ,onPressed: (){
                           Get.showOverlay(loadingWidget: const CircularProgressIndicator(color: Colors.white,),asyncFunction: ()=> bannerController.deleteBanner(id:bannerController.bannersList.value.banners![index].id!,index: index));
                      }, child:const Text('Delete')),
                    )
                                        ]
                                        ,
                                      )
                                    ),
                                  );
                                },
                                itemCount: bannerController.bannersList.value.banners!.length,
                              
                            ),
                       );
                       }
                       else
                       {
                        return Center(child: Column(
                          children: [
                            SizedBox(height: Get.height*0.4,),
                            Padding(padding: const EdgeInsets.all(10),child: Text('No banners available',style: TextStyle(fontSize: 12.sp),),),
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
