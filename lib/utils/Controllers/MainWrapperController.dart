
import 'package:educationadmin/screens/pages/creator/CreaterHome.dart';

import 'package:educationadmin/screens/pages/HomeScreen.dart';
import 'package:educationadmin/screens/pages/Messages.dart';
import 'package:educationadmin/screens/pages/Profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../screens/pages/Explore2.dart';





class MainWrapperController extends GetxController {
  late PageController pageController;

  RxInt currentPage = 0.obs;
  RxBool isDarkTheme = false.obs;

  List<Widget> pages = [
    const HomeScreen(),
    const ExploreScreen(),
     ChatScreen(),
   const  CreaterHome(),
   ProfileScreen(),
  ];

  ThemeMode get theme => Get.isDarkMode ? ThemeMode.dark : ThemeMode.light;

  void switchTheme(ThemeMode mode) {
    Get.changeThemeMode(mode);
  }

  void goToTab(int page) {
    Logger().e("Going to page $page");
    currentPage.value = page;
    pageController.jumpToPage(page);
  }
  void animateToTab(int page) {
    Logger().e("Animating to page $page");
    currentPage.value = page;
   pageController.animateToPage(page,
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease);
  }

  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    super.onInit();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}