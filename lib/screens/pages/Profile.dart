import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../authentication/LoginScreen.dart';
import '../../utils/Controllers/AuthenticationController.dart';
import '../../utils/Controllers/UserController.dart';
import '../common/UpdatePeofileScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
void main() {
  runApp(ProfileScreen());
}

class ProfileScreen extends StatelessWidget {
  final UserDetailsManager userDetailsManager = Get.find<UserDetailsManager>();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const  BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
             Color(0xFFF5FDF0), // Extremely Light Greenish-Yellow Shade 1
              Color(0xFFF2FBE3), // Extremely Light Greenish-Yellow Shade 2
              Color(0xFFEFF9D6), // Extremely Light Greenish-Yellow Shade 3
              Color(0xFFECF7C9), // Extremely Light Greenish-Yellow Shade 4
            ],
            stops: [0.1, 0.4, 0.7, 0.9],
          ),
        ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        
        body: SingleChildScrollView(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              
              Padding(
                padding:  EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top, left: 16.0),
                child: Container(
                  color: Colors.transparent, // Set username section background color to white
                  padding: const EdgeInsets.all(16.0),
                  child: Obx(
                    ()=>  Row(
                      children: <Widget>[
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
                        SizedBox(width: 16.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              userDetailsManager.username.value, // Replace with the user's name
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black, // Set username text color to black
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              '123K Followers', // Replace with user-related details
                              style: TextStyle(
                                color: Colors.black, // Set user details text color to black
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ElevatedCard(const Icon(Icons.edit), 'Edit Profile', () {
                Get.to(()=> ProfileUpdateScreen());
              }),
              ElevatedCard(const Icon(Icons.file_download), 'Downloads', () {
                // Handle downloads
              }),
              ElevatedCard(const Icon(Icons.lock), 'Change Password', () {
                // Handle change password
              }),
              ElevatedCard(const Icon(Icons.camera_alt), 'Update Profile Picture', () {
              
              }),
              ElevatedCard(const Icon(Icons.exit_to_app), 'Logout', () {
                AuthenticationManager authenticationManager=Get.put(AuthenticationManager());
                authenticationManager.logOut();
                Get.offAll(()=>const LoginScreen());
              }),
              // Additional content can be added here
            ],
          ),
        ),
      ),
    );
  }

  Widget ElevatedCard(Icon leadingIcon, String title, VoidCallback onPressed) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: InkWell(
        onTap: onPressed,
        child: ListTile(
          leading: leadingIcon,
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}