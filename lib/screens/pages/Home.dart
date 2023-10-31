
import 'package:educationadmin/screens/pages/HomeScreen.dart';
import 'package:educationadmin/utils/Controllers/UserController.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:getwidget/getwidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserDetailsManager userDetailsManager = Get.find<UserDetailsManager>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(0.0),
        physics: BouncingScrollPhysics(),
        child: Container(
          height: Get.height,
          width: Get.width,
          child: LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Container(
                      height: Get.height * 0.2,
                      width: Get.width * 0.9,
                      child: LayoutBuilder(
                          builder: (context, containerConstraints) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: (){
                                Get.to(()=>HomeScreen());
                              },
                              child: CircleAvatar(
                                radius: containerConstraints.maxHeight * 0.2,
                              ),
                            ),
                            SizedBox(
                              width: constraints.maxWidth * 0.02,
                            ),
                            Text(
                              'Welcome ${userDetailsManager.username}',
                              style: TextStyle(
                                  fontSize: 15.sp, fontWeight: FontWeight.bold),
                            ),
                          ],
                        );
                      }),
                    )),
                // GFSearchBar(searchList: [], overlaySearchListItemBuilder: overlaySearchListItemBuilder, searchQueryBuilder: searchQueryBuilder)

                Container(
                  decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20.0)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade100,
                          blurRadius: 25.0,
                        ),
                      ]),
                  height: Get.height * 0.15,
                  width: Get.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              "Top Categories",
                              style: TextStyle(
                                  fontSize: 15.sp, fontWeight: FontWeight.bold),
                            ),
                          ),
                          TextButton(
                            child: Text(
                              "View All",
                              style: TextStyle(
                                  color: Color(0xff4FAEDA),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                            onPressed: () {},
                          )
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.08,
                        child: ListView.builder(
                            itemCount: 10,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Category $index',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      foregroundColor: Colors.white),
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight*0.02,
                ),
                Container(
                decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20.0)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade100,
                          blurRadius: 25.0,
                        ),
                      ]),

                  height: Get.height * 0.4,
                  width: Get.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              "My Courses",
                              style: TextStyle(
                                  fontSize: 15.sp, fontWeight: FontWeight.bold),
                            ),
                          ),
                          TextButton(
                            child: Text(
                              "View All",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                            onPressed: () {},
                          )
                        ],
                      ),
                      Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                height: Get.height * 0.1,
                                width: Get.width * 0.65,
                                child: GFCard(
                                  gradient: index % 2 == 0
                                      ? const LinearGradient(
                                          begin: Alignment.topRight,
                                          end: Alignment.bottomLeft,
                                          colors: [
                                            Color(0xffFFA56B),
                                            Color(0xffFF8551),
                                          ],
                                        )
                                      : const LinearGradient(
                                          begin: Alignment.topRight,
                                          end: Alignment.bottomLeft,
                                          colors: [
                                              Color(0xff05D5DB),
                                              Color(0xff05B7A3)
                                            ]),
                                  boxFit: BoxFit.cover,
                                  titlePosition: GFPosition.start,
                                  // image: Image.asset(
                                  //   'assets/google.svg',
                                  //   height: MediaQuery.of(context).size.height * 0.2,
                                  //   width: MediaQuery.of(context).size.width,
                                  //   fit: BoxFit.cover,
                                  // ),
                                  showImage: true,
                                  title: const GFListTile(
                                    // avatar: GFAvatar(
                                    //   backgroundImage: AssetImage('your asset image'),
                                    // ),
                                    titleText: 'Title',
                                    subTitleText: 'Sub Title',
                                  ),
                                  content: Text(
                                      "Some quick example text to build on the card"),
                                  //  buttonBar: const GFButtonBar(
                                  //    children: <Widget>[
                                  //      GFAvatar(
                                  //        child: Icon(
                                  //          Icons.settings,
                                  //          color: Colors.white,
                                  //        ),
                                  //      ),
                                  //      GFAvatar(
                                  //        backgroundColor: GFColors.DARK,
                                  //        child: Icon(
                                  //          Icons.home,
                                  //          color: Colors.white,
                                  //        ),
                                  //      ),
                                  //      GFAvatar(
                                  //        backgroundColor: GFColors.DANGER,
                                  //        child: Icon(
                                  //          Icons.help,
                                  //          color: Colors.white,
                                  //        ),
                                  //      ),
                                  //    ],
                                  //  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
