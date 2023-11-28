
import 'package:educationadmin/utils/ColorConstants.dart';
import 'package:educationadmin/utils/Controllers/MainWrapperController.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:logger/logger.dart';



class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
   final MainWrapperController _mainWrapperController =
      Get.put(MainWrapperController());
 final List<int> tabHistory = [0]; // Initialize with the first tab (index 0).
 Logger logger=Logger();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      bottomNavigationBar: BottomAppBar(
       
        
        notchMargin: 10,
        child: Container(
          //color: Theme.of(context).appBarTheme.backgroundColor,
          padding:  EdgeInsets.symmetric( vertical: Get.bottomBarHeight),
          child: Obx(
            () => WillPopScope(
              onWillPop: _onBackPressed,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _bottomAppBarItem(
                    icon: FontAwesomeIcons.house,
                    page: 0,
                    context,
                    label: "Home",
                  ),
                  _bottomAppBarItem(
                      icon: FontAwesomeIcons.compass,
                      page: 1,
                      context,
                      label: "Explore"),
                  _bottomAppBarItem(
                      icon: FontAwesomeIcons.solidMessage,
                      page: 2,
                      context,
                      label: "Messages"),
                   _bottomAppBarItem(
                      icon: FontAwesomeIcons.tv,
                      page: 3,
                      context,
                      label: "Studio"),    
                  _bottomAppBarItem(
                      icon: FontAwesomeIcons.user,
                      page: 4,
                      context,
                      label: "Profile"),
                ],
              ),
            ),
          ),
        ),
      ),
      body: PageView(
        padEnds: false,
        controller: _mainWrapperController.pageController,
        physics: const BouncingScrollPhysics(),
        onPageChanged: (index){
          logger.e("Adding $index");
          if(index==0)
          {tabHistory.clear();
          tabHistory.add(index);}
          else
          {
            tabHistory.add(index);
          }
          _mainWrapperController.animateToTab(index);
        },
        children: [..._mainWrapperController.pages],
      ),
    );
  }

  Widget _bottomAppBarItem(BuildContext context,
      {required icon, required page, required label}) {
    return ZoomTapAnimation(
      onTap: () => _mainWrapperController.goToTab(page),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: _mainWrapperController.currentPage == page
                ? CustomColors.primaryColorDark
                : Colors.grey,
            size: 2.5.h,
          ),
          Text(
            label,
            style: TextStyle(
                color: _mainWrapperController.currentPage == page
                    ? CustomColors.primaryColorDark
                    : Colors.grey,
                fontSize: 10.sp,
                fontWeight: _mainWrapperController.currentPage == page
                    ? FontWeight.w600
                    : null),
          ),
        ],
      ),
    );
  }


  Future<bool> _onBackPressed() {
    if (tabHistory.isNotEmpty) {
      // If there is tab history, pop the last tab and switch to it.
      logger.e("Current tab list is ${tabHistory.toString()}");
      tabHistory.removeLast();
      int lastTab=tabHistory.removeLast();
      _mainWrapperController.goToTab(lastTab);
      return Future.value(false);
    } else {
      // If there is no more tab history, allow the back button to exit the application.
      return Future.value(true);
    }
  }
}