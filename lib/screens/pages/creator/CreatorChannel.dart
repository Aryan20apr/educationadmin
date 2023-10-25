import 'dart:io';

import 'package:circular_menu/circular_menu.dart';
import 'package:educationadmin/screens/pages/creator/ChannelOptionController.dart';
import 'package:educationadmin/screens/pages/creator/ChannelWidgets.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

import '../../../Modals/ChannelListModal.dart';

class CreatorChannel extends StatefulWidget {
  const CreatorChannel({super.key,required this.channel});
 final Channels channel;

  @override
  State<CreatorChannel> createState() => _CreatorChannelState();
}

class _CreatorChannelState extends State<CreatorChannel> {
  final ChannelOptionsController channelOptionsController =
      Get.put(ChannelOptionsController());

       TextEditingController fileNameController = TextEditingController();
  File? selectedPDF;

  Future<File?> requestPermissionAndPickPDFFile() async {
    PermissionStatus status = await Permission.storage.request();
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    if (status.isGranted) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null && result.files.isNotEmpty) {
        return File(result.files.first.path!);
      }
    }
  
    return null;
  }

  Future<void> showAddFileDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add PDF File"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
             if(selectedPDF!=null) Text(selectedPDF!.path),
              ElevatedButton(
                onPressed: () async {
                  File? pdfFile = await requestPermissionAndPickPDFFile();
                  if (pdfFile != null) {
                    setState(() {
                      selectedPDF = pdfFile;
                    });
                  }
                },
                child: Text("Choose PDF File"),
              ),
              if (selectedPDF != null)
                Column(
                  children: [
                    SizedBox(height: 10),
                    TextField(
                      controller: fileNameController,
                      decoration: InputDecoration(
                        labelText: "File Name",
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        String fileName = fileNameController.text;
                        if (fileName.isNotEmpty) {
                          // Implement your logic to upload the PDF file with the chosen name
                          // For example: File(selectedPDF.path).copy('$yourFilePath/$fileName.pdf');
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text("Upload"),
                    ),
                  ],
                ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }
  void _handleOptionSelected(String option) {
    switch (option) {
      case "Add Video":
        // Implement your logic for adding a video here
        break;
      case "Add File":
        // Implement your logic for adding a file here
        showAddFileDialog(context);
        break;
      case "Add Subscriber":
        // Implement your logic for adding a subscriber here
        Get.defaultDialog(
          backgroundColor: Colors.white,
          title: "Enter phone number of new subscriber",
          titleStyle: TextStyle(fontSize: 14.sp),
          content: Column(
            children: [
              TextField(
                keyboardType: TextInputType.phone,
                onChanged: (value) {
                  channelOptionsController.updatePhoneNumber(value);
                },
                decoration:  InputDecoration(labelText: "Phone Number",hintStyle: TextStyle(fontSize: 12.sp)),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Implement your logic to add a subscriber with dialogController.phoneNumber.value
                  Get.back(); // Close the dialog
                },
                child: const Text("Add Subscriber"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red,foregroundColor: Colors.white,elevation: 10),
              ),
            ],
          ),
        );
        break;
        
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CircularMenu(
        alignment: Alignment.bottomRight,
        toggleButtonColor:
            Colors.red, // Color of the central floating action button
        toggleButtonSize:
            Get.width * 0.1, // Size of the central floating action button
        items: [
          CircularMenuItem(
            icon: Icons.video_library,
            color: Colors.blue,
            onTap: () {
              _handleOptionSelected("Add Video");
            },
          ),
          CircularMenuItem(
            icon: Icons.attach_file,
            color: Colors.green,
            onTap: () {
              _handleOptionSelected("Add File");
            },
          ),
          CircularMenuItem(
            icon: Icons.person_add,
            color: Colors.orange,
            onTap: () {
              _handleOptionSelected("Add Subscriber");
            },
          ),
        ],
      ),
      body: DefaultTabController(
        length: 4,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                foregroundColor: Colors.white,
                expandedHeight: Get.height * 0.25,
                pinned: true,
                floating: false,
                backgroundColor: Colors.red, // YouTube red color
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    "${widget.channel.name}",
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  background: Image.network(
                    'https://img.freepik.com/free-photo/multi-color-fabric-texture-samples_1373-434.jpg?t=st=1698132567~exp=1698133167~hmac=4cefa7b45b26f445d5823b41320e1c572ef6a98f6313f54ce351f818b03cc26e',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  const TabBar(
                    isScrollable: true,
                    labelColor: Colors.red,
                    indicatorColor: Colors.red, // YouTube red color
                    tabs: [
                      Tab(text: 'Videos'),
                      Tab(text: 'Files'),
                      Tab(text: 'Your subscribers'),
                      Tab(text: 'About'),
                    ],
                  ),
                ),
                pinned: true,
                floating: false,
              ),
            ];
          },
          body: TabBarView(
            children: [
              // Videos Tab Content
              VideosTab(channelId: widget.channel.id!,createrId: widget.channel.createdBy!,),
              // Files Tab Content
              FilesTab(channelId: widget.channel.id!,createrId: widget.channel.createdBy!),
              SubscribersTab(channelId: widget.channel.id!,createrId: widget.channel.createdBy!),
              // About Tab Content
              DescriptionTab(channelId: widget.channel.id!,createrId: widget.channel.createdBy!)
            ],
          ),
        ),
      ),
    );
  }

   
}



class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(color: Colors.white, child: Center(child: _tabBar));
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
