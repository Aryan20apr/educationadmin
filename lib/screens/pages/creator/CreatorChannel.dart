import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_menu/circular_menu.dart';
import 'package:educationadmin/Modals/VideoRequestModal.dart';
import 'package:educationadmin/screens/pages/creator/ChannelOptionController.dart';
import 'package:educationadmin/screens/pages/creator/DescriptionTab.dart';
import 'package:educationadmin/screens/pages/creator/LiveVideosTab.dart';
import 'package:educationadmin/utils/ColorConstants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'package:logger/logger.dart';
import '../../../Modals/ChannelListModal.dart';
import 'FilesTab.dart';
import 'SubscribersTab.dart';
import 'VideosTab.dart';
import 'NoticeBottomSheet.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
class CreatorChannel extends StatefulWidget {
  const CreatorChannel({super.key,required this.channel});
 final Channels channel;


  @override
  State<CreatorChannel> createState() => _CreatorChannelState();
}

class _CreatorChannelState extends State<CreatorChannel> {
  final ChannelOptionsController channelOptionsController =
      Get.put(ChannelOptionsController());
late  NoticeBottomSheet noticeBottomSheet;
       TextEditingController fileNameController = TextEditingController();
       TextEditingController videoTitleTextEditingController=TextEditingController();
       TextEditingController videoUrlcontroller=TextEditingController();
        Logger logger=Logger();
        
  //File? selectedPDF;
final _formKey = GlobalKey<FormState>();

@override
void initState(){
  noticeBottomSheet=NoticeBottomSheet();
  super.initState();
}
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
                Get.back();
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
                    Obx(
                      ()=> Switch(
                        value: channelOptionsController.isVideoPaid.value, // Set the initial value as needed
                        onChanged: (value) {
                          
                          // Handle the switch state change
                          channelOptionsController.isVideoPaid.value=value;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Obx(
                  ()=>channelOptionsController.isLoading.value==false? ElevatedButton(
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
                  ):const ButtonProgressWidget(),
                ),
              ],
            ),
          ),
        ),
      ),
    )
              );
  }
   void showLiveVideoDialog(BuildContext context)
  {
    videoTitleTextEditingController.text='';
    videoUrlcontroller.text='';
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
                 Text(
                  "Schedule a new live video",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                 SizedBox(height: Get.height*0.01),
                TextFormField(
                  controller: videoTitleTextEditingController,
                  decoration: const InputDecoration(labelText: 'Title',labelStyle: TextStyle(color: Colors.grey)),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: videoUrlcontroller,
                  decoration: const InputDecoration(labelStyle: TextStyle(color: Colors.grey),labelText: 'Live video link from Youtube'),
                  validator: (value) {
                    // Add your link validation regex here
                    // For example, to require a valid URL:
                    if (!Uri.tryParse(value??"")!.isAbsolute == true) {
                      return 'Please enter a valid URL';
                    }
                    return null;
                  },
                ),
                SizedBox(height: Get.height*0.02,),
                                SizedBox(height: Get.height*0.01,),
                Text('Choose Date and Time below',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 12.sp)),
                SizedBox(height: Get.height*0.01,),
                 GestureDetector(
                  onTap: () async {
                    DateTime? selectedDate = await
 
showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate:
 
DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (selectedDate != null) {
                      if( channelOptionsController.selectedDateTime.value != null)
                      {
                         channelOptionsController.selectedDateTime.value =channelOptionsController.selectedDateTime.value.copyWith(
                       year:selectedDate.year,
                      month: selectedDate.month,
                       day:selectedDate.day,
                      );
                      }
                      else
                      {
                      channelOptionsController.selectedDateTime.value = DateTime(
                        selectedDate.year,
                        selectedDate.month,
                        selectedDate.day,
                      );
                      }
                    }
                  },
                  child: Row(
                    children: [
                      Icon(Icons.calendar_month_rounded,size: 12.sp,),
                       Text('Scheduled Date:',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 12.sp
                    ),),
                      Obx(
                        () => Text(
                            channelOptionsController.selectedDateTime.value != null
                              ? DateFormat('yyyy-MM-dd').format(  channelOptionsController.selectedDateTime.value)
                              : 'Select a date',
                        ),
                      ),
                    ],
                  ),
                ),

                GestureDetector(
                  onTap: () async {
                    TimeOfDay? selectedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (selectedTime != null) {
                      if (  channelOptionsController.selectedDateTime.value != null) {
                         channelOptionsController.selectedDateTime.value =   channelOptionsController.selectedDateTime.value.copyWith(
                          hour: selectedTime.hour,
                          minute: selectedTime.minute,
                        );
                      } else {
                          channelOptionsController.selectedDateTime.value = DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          DateTime.now().day,
                          selectedTime.hour,
                          selectedTime.minute,
                        );
                      }
                    }
                  },

                  child: Row(
                    children: [
                      Icon(Icons.schedule_rounded,size: 12.sp,),
                       Text('Scheduled Time:',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 12.sp
                    )),
                      Obx(
                        () => Text(
                            channelOptionsController.selectedDateTime.value != null
                              ? DateFormat('HH:mm').format(  channelOptionsController.selectedDateTime.value)
                              : 'Select a time',
                        ),
                      ),
                    ],
                  ),
                ),
                 SizedBox(height: Get.height*0.02),
                Row(
                  children: <Widget>[
                     Text('Paid Video:',style: TextStyle( color: Colors.black,fontWeight: FontWeight.w400,fontSize: 12.sp),),
                    Obx(
                      ()=> Switch(
                        value: channelOptionsController.isVideoPaid.value, // Set the initial value as needed
                        onChanged: (value) {
                          
                          // Handle the switch state change
                          channelOptionsController.isVideoPaid.value=value;
                        },
                      ),
                    ),
                  ],
                ),
               SizedBox(height: Get.height*0.01),
                Obx(
                  ()=>channelOptionsController.isLoading.value==false? ElevatedButton(
                    onPressed: () {
                     validateFieldsAndUploadLive();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: const Size(200, 50), // Adjust button size as needed
                    ),
                    child: const Text('Upload Video'),
                  ):const ButtonProgressWidget(),
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
   bool validateFieldsAndUploadLive() {
    if (_formKey.currentState!.validate()) {
                     channelOptionsController.uploadLiveVideo(videoRequestModal: VideoRequestModal(title:videoTitleTextEditingController.text,link: videoUrlcontroller.text,isPaid:channelOptionsController.isVideoPaid.value.toString(),type: 'Video',channelId: widget.channel.id));
                    }
    return true; // Replace with your validation logic.
  }
  void _handleOptionSelected(String option) {
    switch (option) {
      case "New Notice":
        noticeBottomSheet.showCreateNoticeBottomSheet(context: context, channeId: widget.channel.id!);
      case "Add Video":
        showAddVideoDialog(context);
        break;
      case "Add Live Video":
      showLiveVideoDialog(context);
      case "Add File":
        // Implement your logic for adding a file here
        showAddFileDialog(context);
        break;
      case "Add Subscriber":
        // Implement your logic for adding a subscriber here
        channelOptionsController.phoneNumber.value='';
        TextEditingController texteditingController=TextEditingController(text:channelOptionsController.phoneNumber.value);
        Get.defaultDialog(
          backgroundColor: Colors.white,
          title: "  Enter phone number of new subscriber  ",
          titleStyle: TextStyle(fontSize: 12.sp),
          content:Obx(
            ()=> Column(
              children: [
                TextField(
                  controller: texteditingController,
                  keyboardType: TextInputType.phone,
                  onChanged: (value) {
                    channelOptionsController.updatePhoneNumber(value);
                  },
                  decoration:  InputDecoration(labelText: "Phone Number",hintStyle: TextStyle(fontSize: 12.sp)),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  
                  onPressed: ()async {
                    if(channelOptionsController.phoneNumber.value.isNotEmpty) {
                      await channelOptionsController.addSubscriber(channeId: widget.channel.id! );
                    }
                   
                  },
                  style: ElevatedButton.styleFrom(fixedSize: Size(Get.width*0.5, Get.width*0.1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),backgroundColor: CustomColors.primaryColor,elevation: 10,),
                  child: channelOptionsController.isLoading.value?const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(color: CustomColors.primaryColorDark,),
                  ):  Text("Add Subscriber",style: TextStyle(color: CustomColors.primaryColorDark,fontSize: 12.sp),),
                ),
              ],
            ),
          ),
        );
        break;
        
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        floatingActionButton: CircularMenu(
          alignment: Alignment.bottomRight,
          radius: 120,
          toggleButtonColor:
              Colors.red, // Color of the central floating action button
          toggleButtonSize:
              Get.width * 0.1, // Size of the central floating action button
          items: [
            CircularMenuItem(
              icon: Icons.video_library,
              color: Colors.blue,
              padding: 10,
              iconSize: 25,
              onTap: () {
                _handleOptionSelected("Add Video");
              },
            ),
             CircularMenuItem(
               padding: 10,
              iconSize: 25,
              icon: Icons.live_tv_rounded,
              color: Colors.tealAccent,
              onTap: () {
                _handleOptionSelected("Add Live Video");
              },
            ),
            CircularMenuItem(
               padding: 10,
              iconSize: 25,
              icon: Icons.attach_file,
              color: Colors.green,
              onTap: () {
                _handleOptionSelected("Add File");
              },
            ),
            CircularMenuItem(
               padding: 10,
              iconSize: 25,
              icon: Icons.person_add,
              color: Colors.orange,
              onTap: () {
                _handleOptionSelected("Add Subscriber");
              },
            ),
            CircularMenuItem(
               padding: 10,
              iconSize: 25,
              icon: Icons.note_add_rounded,
              color: Colors.purple,
              onTap: () {
                _handleOptionSelected("New Notice");
              },)
          ],
        ),
        body: DefaultTabController(
          length: 5,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  foregroundColor: CustomColors.secondaryColor,
                  expandedHeight: Get.height * 0.25,
                  pinned: true,
                  floating: false,
                  backgroundColor: CustomColors.createrColour, // YouTube red color
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text(
                      "${widget.channel.name}",
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.secondaryColor),
                    ),
                    background: CachedNetworkImage(
                                colorBlendMode: BlendMode.darken,
                                                imageUrl: widget.channel.thumbnail!,
                              placeholder: (context, url) => Image.asset(
                                'assets/default_image.png',
                                fit: BoxFit.cover // Set the height to match the diameter of the CircleAvatar
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                'assets/default_image.png',
                                fit: BoxFit.cover,
                                // Set the height to match the diameter of the CircleAvatar
                              ),
                              fit: BoxFit.cover,
                                              ),/*Image.network(
                      widget.channel.thumbnail!,
                      fit: BoxFit.cover,
                    ),*/
                  ),
                ),
                SliverPersistentHeader(
                  delegate: _SliverAppBarDelegate(
                    const TabBar(
                      isScrollable: true,
                      labelColor: Colors.red,
                      indicatorColor: Colors.red, // YouTube red color
                      tabs: [
                        Tab(text: 'Recordings'),
                         Tab(text: 'Live'),
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
                LiveVideosTab(channelId: widget.channel.id!,createrId: widget.channel.createdBy!,),
                // Files Tab Content
                FilesTab(channelId: widget.channel.id!,createrId: widget.channel.createdBy!),
                SubscribersTab(channelId: widget.channel.id!,createrId: widget.channel.createdBy!),
                // About Tab Content
                DescriptionTab(channelId: widget.channel.id!,createrId: widget.channel.createdBy!)
              ],
            ),
          ),
        ),
      ),
    );
  }

   
}

class ButtonProgressWidget extends StatelessWidget {
  const ButtonProgressWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: 
    (){}, child:const CircularProgressIndicator());
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
