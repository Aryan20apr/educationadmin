import 'dart:io';

import 'package:talentsearchenglish/utils/ColorConstants.dart';
import 'package:talentsearchenglish/utils/Controllers/UserController.dart';
import 'package:talentsearchenglish/widgets/ProgressIndicatorWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfileUpdateScreen extends StatefulWidget {
  const ProfileUpdateScreen({
    super.key,
  });

  @override
  State<ProfileUpdateScreen> createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  final UserDetailsManager _profileController = Get.put(UserDetailsManager());

  late TextEditingController usernameController;
  late TextEditingController emailController;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    usernameController =
        TextEditingController(text: _profileController.username.value);
    emailController =
        TextEditingController(text: _profileController.email.value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Profile"),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: SizedBox(
            height:
                MediaQuery.of(context).size.height - kBottomNavigationBarHeight,
            width: MediaQuery.of(context).size.width,
            child: LayoutBuilder(
              builder: (context, constraints) {
                double avatarSize = constraints.maxWidth * 0.2;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: Get.height * 0.05,
                    ),
                    GestureDetector(
                        onTap: () {
                          _profileController.pickImage();
                        },
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Obx(
                              () => Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: CustomColors.primaryColor,
                                      width: 4.0,
                                    )),
                                child: ClipOval(
                                  child: CircleAvatar(
                                      radius: avatarSize,
                                      backgroundColor: Colors.grey.shade300,
                                      child: _profileController
                                              .imagePath.isNotEmpty
                                          ? Image(
                                              image: FileImage(
                                                File(_profileController
                                                    .imagePath.value),
                                              ),
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                              height: double.infinity,
                                            )
                                          : _profileController
                                                  .image.value.isNotEmpty
                                              ? CachedNetworkImage(
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                  colorBlendMode:
                                                      BlendMode.darken,
                                                  imageUrl: _profileController
                                                      .image.value,
                                                  placeholder: (context, url) =>
                                                      Image.asset(
                                                    'assets/default_image.png',
                                                    height:
                                                        constraints.maxHeight *
                                                            0.1,
                                                    fit: BoxFit.fill,
                                                    // width: Get.width * 0.1 * 2, // Set the width to match the diameter of the CircleAvatar
                                                    // height: Get.width * 0.1 * 2, // Set the height to match the diameter of the CircleAvatar
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Image.asset(
                                                    'assets/default_image.png',

                                                    fit: BoxFit.fill,
                                                    width: constraints
                                                            .maxWidth *
                                                        0.2, // Set the width to match the diameter of the CircleAvatar
                                                    height: constraints
                                                            .maxHeight *
                                                        0.1, // Set the height to match the diameter of the CircleAvatar
                                                  ),
                                                  fit: BoxFit.cover,
                                                )
                                              : Icon(
                                                  Icons.person,
                                                  size: constraints.maxWidth *
                                                      0.2,
                                                )),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 2,
                              right: 20,
                              child: Container(
                                height: Get.height * 0.05,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: CustomColors.primaryColor,
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                    SizedBox(height: constraints.maxHeight * 0.05),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Form(
                              key: _formKey,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    TextFormField(
                                      controller: usernameController,
                                      decoration: InputDecoration(
                                        labelText: "Username",
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(),
                                        ),
                                        //fillColor: Colors.green
                                      ),
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return "Username cannot be empty";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height: constraints.maxHeight * 0.05,
                                    ),
                                    TextFormField(
                                      controller: emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        labelText: "Email",
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(),
                                        ),
                                        //fillColor: Colors.green
                                      ),
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return "Email cannot be empty";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height: constraints.maxHeight * 0.05,
                                    ),
                                    Obx(
                                      () => ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            fixedSize: Size(Get.width * 0.8,
                                                Get.height * 0.08),
                                            elevation: 10,
                                            foregroundColor: Colors.white,
                                            backgroundColor:
                                                CustomColors.primaryColor,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            if (_profileController
                                                    .isUpdating.value ==
                                                false) {
                                              _profileController.updateProfile(
                                                  email: emailController.text,
                                                  username:
                                                      usernameController.text);
                                            }
                                          }
                                        },
                                        child: _profileController
                                                .isUpdating.value
                                            ? const ProgressIndicatorWidget()
                                            : const Text("Update Profile"),
                                      ),
                                    ),
                                    SizedBox(
                                      height: constraints.maxHeight * 0.05,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _profileController.imagePath.value = '';
    super.dispose();
  }
}
