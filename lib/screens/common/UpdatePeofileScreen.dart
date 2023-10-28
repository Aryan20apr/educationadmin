import 'dart:io';

import 'package:educationadmin/utils/Controllers/UserController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ProfileUpdateScreen extends StatelessWidget {
  final UserDetailsManager _profileController = Get.put(UserDetailsManager());

  ProfileUpdateScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Profile"),
      ),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double avatarSize = constraints.maxWidth * 0.4;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    _profileController.pickImage();
                  },
                  child: Obx(() {
                    return Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          width: avatarSize,
                          height: avatarSize,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.blue,
                              width: 3.0,
                            ),
                            image: _profileController.imagePath.isNotEmpty
                                ? DecorationImage(
                                    image: FileImage(
                                      File(_profileController.imagePath.value),
                                    ),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: _profileController.imagePath.isEmpty
                              ?Icon(
                                  Icons.person,
                                  size: avatarSize * 0.8,
                                  color: Colors.grey,
                                )
                              : null,
                        ),
                        if (_profileController.imagePath.isEmpty)
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue,
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                      ],
                    );
                  }),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _profileController.uploadProfileImage();
                  },
                  child: const Text("Update Profile"),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}


