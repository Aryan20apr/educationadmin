
import 'package:educationadmin/utils/ColorConstants.dart';
import 'package:educationadmin/utils/Controllers/MainWrapperController.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'package:zoom_tap_animation/zoom_tap_animation.dart';




class MainWrapper extends StatefulWidget {
  MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
   final MainWrapperController _mainWrapperController =
      Get.put(MainWrapperController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        notchMargin: 10,
        child: Container(
          
          padding:  EdgeInsets.symmetric( vertical: Get.bottomBarHeight),
          child: Obx(
            () => Row(
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
      body: PageView(
        padEnds: false,
        controller: _mainWrapperController.pageController,
        physics: const BouncingScrollPhysics(),
        onPageChanged: _mainWrapperController.animateToTab,
        children: [..._mainWrapperController.pages],
      ),
    );
  }

  Widget _bottomAppBarItem(BuildContext context,
      {required icon, required page, required label}) {
    return ZoomTapAnimation(
      onTap: () => _mainWrapperController.goToTab(page),
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: _mainWrapperController.currentPage == page
                  ? ColorConstants.appColors
                  : Colors.grey,
              size: 2.5.h,
            ),
            Text(
              label,
              style: TextStyle(
                  color: _mainWrapperController.currentPage == page
                      ? ColorConstants.appColors
                      : Colors.grey,
                  fontSize: 12.sp,
                  fontWeight: _mainWrapperController.currentPage == page
                      ? FontWeight.w600
                      : null),
            ),
          ],
        ),
      ),
    );
  }
}