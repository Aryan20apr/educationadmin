import 'dart:io';

import 'package:circular_menu/circular_menu.dart';
import 'package:educationadmin/Modals/VideoRequestModal.dart';
import 'package:educationadmin/screens/pages/creator/ChannelOptionController.dart';
import 'package:educationadmin/screens/pages/creator/DescriptionTab.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

import '../../../Modals/ChannelListModal.dart';
import 'FilesTab.dart';
import 'SubscribersTab.dart';
import 'VideosTab.dart';

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
       TextEditingController videoTitleTextEditingController=TextEditingController();
       TextEditingController videoUrlcontroller=TextEditingController();

  //File? selectedPDF;
final _formKey = GlobalKey<FormState>();
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
    channelOptionsController.filePath.value="";
    channelOptionsController.isFilePaid.value=false;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add PDF File"),
          content: Obx(
            ()=> SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                 if(channelOptionsController.filePath.value.isEmpty==false) Text(channelOptionsController.filePath.value),
                  ElevatedButton(
                    onPressed: () async {
                      File? pdfFile = await requestPermissionAndPickPDFFile();
                      if (pdfFile != null) {
                        // setState(() {
                        //   selectedPDF = pdfFile;
                        // });
                        channelOptionsController.filePath.value=pdfFile.path;
                      }
                    },
                    child: const Text("Choose PDF File"),
                  ),
                  if ( channelOptionsController.filePath.value.isEmpty==false)
                    Column(
                      children: [
                        const SizedBox(height: 10),
                        TextField(
                          controller: fileNameController,
                          decoration: const InputDecoration(
                            labelText: "File Name",
                          ),
                        ),
                        const SizedBox(height: 10),
                         Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children:[ const Text('Is File Paid'),Switch(
                                               value: channelOptionsController.isFilePaid.value, // Set the initial value as needed
                                               onChanged: (value) {
                            // Handle the switch state change
                            channelOptionsController.isFilePaid.value=value;
                                               },
                                             ),]
                         ),
                        const SizedBox(height: 10,),
                        ElevatedButton(
                          onPressed: () async{
                            String fileName = fileNameController.text;
                            if (fileName.isNotEmpty) {
                            await channelOptionsController.uploadFile(title:fileName, channeId: widget.channel.id!);
                             setState(() {
                               
                             });
                            }
                          },
                          child: const Text("Upload"),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }
  void showAddVideoDialog(BuildContext context)
  {
    showDialog(
                context: context,
                builder: (context) =>  Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  "Upload New Video",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: videoTitleTextEditingController,
                  decoration: const InputDecoration(labelText: 'Title'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: videoUrlcontroller,
                  decoration: const InputDecoration(labelText: 'Video Link'),
                  validator: (value) {
                    // Add your link validation regex here
                    // For example, to require a valid URL:
                    if (!Uri.tryParse(value??"")!.isAbsolute == true) {
                      return 'Please enter a valid URL';
                    }
                    return null;
                  },
                ),
                Row(
                  children: <Widget>[
                    const Text('Paid Video:'),
                    Switch(
                      value: false, // Set the initial value as needed
                      onChanged: (value) {
                        // Handle the switch state change
                        channelOptionsController.isVideoPaid.value=value;
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                   validateFieldsAndUpload();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: const Size(200, 50), // Adjust button size as needed
                  ),
                  child: const Text('Upload Video'),
                ),
              ],
            ),
          ),
        ),
      ),
    )
              );
  }
   bool validateFieldsAndUpload() {
    if (_formKey.currentState!.validate()) {
                     channelOptionsController.uploadVideo(videoRequestModal: VideoRequestModal(title:videoTitleTextEditingController.text,link: videoUrlcontroller.text,isPaid:channelOptionsController.isVideoPaid.value.toString(),type: 'Video',channelId: widget.channel.id ));
                    }
    return true; // Replace with your validation logic.
  }
  void _handleOptionSelected(String option) {
    switch (option) {
      case "Add Video":
        showAddVideoDialog(context);
        break;
      case "Add File":
        // Implement your logic for adding a file here
        showAddFileDialog(context);
        break;
      case "Add Subscriber":
        // Implement your logic for adding a subscriber here
        Get.defaultDialog(
          backgroundColor: Colors.white,
          title: "Enter id number of new subscriber",
          titleStyle: TextStyle(fontSize: 14.sp),
          content: Column(
            children: [
              TextField(
                keyboardType: TextInputType.phone,
                onChanged: (value) {
                  channelOptionsController.updatePhoneNumber(value);
                },
                decoration:  InputDecoration(labelText: "Id",hintStyle: TextStyle(fontSize: 12.sp)),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: ()async {
                await channelOptionsController.addSubscriber(channeId: widget.channel.id! );
                 
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red,foregroundColor: Colors.white,elevation: 10),
                child: Obx(()=>channelOptionsController.isLoading.value?const CircularProgressIndicator.adaptive(): const Text("Add Subscriber")),
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
