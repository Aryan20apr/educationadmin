import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_menu/circular_menu.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:educationadmin/Modals/VideoRequestModal.dart';
import 'package:educationadmin/screens/pages/creator/ChannelOptionController.dart';
import 'package:educationadmin/screens/pages/creator/DescriptionTab.dart';
import 'package:educationadmin/screens/pages/creator/LiveVideosTab.dart';
import 'package:educationadmin/utils/ColorConstants.dart';
import 'package:educationadmin/widgets/ProgressIndicatorWidget.dart';
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
  const CreatorChannel({super.key, required this.channel});
  final Channels channel;

  @override
  State<CreatorChannel> createState() => _CreatorChannelState();
}

class _CreatorChannelState extends State<CreatorChannel> {
  final ChannelOptionsController channelOptionsController =
      Get.put(ChannelOptionsController());
  late NoticeBottomSheet noticeBottomSheet;
  TextEditingController fileNameController = TextEditingController();
  TextEditingController videoTitleTextEditingController =
      TextEditingController();
  TextEditingController videoUrlcontroller = TextEditingController();
  Logger logger = Logger();

  //File? selectedPDF;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    noticeBottomSheet = NoticeBottomSheet();
    super.initState();
  }

  Future<File?> requestPermissionAndPickPDFFile() async {
    // PermissionStatus status = await Permission.storage.request();
   
    final androidInfo = await DeviceInfoPlugin().androidInfo;
     logger.i("SDK Version: ${androidInfo.version.sdkInt }");
    if ((androidInfo.version.sdkInt > 32 &&
            await Permission.photos.request().isGranted &&
            await Permission.audio.request().isGranted) ||
        (androidInfo.version.sdkInt <= 32 &&
            await Permission.storage.request().isGranted)) {
      //logger.i("STORAGE REQUEST GRANTED");

      //await Permission.storage.request();
      //logger.i("STORAGE REREQUEST GRANTED:${status.isGranted}");
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null && result.files.isNotEmpty) {
        return File(result.files.first.path!);
      }
    } else if ((androidInfo.version.sdkInt > 32 &&
                await Permission.photos.isPermanentlyDenied ||
            await Permission.audio.isPermanentlyDenied) ||
        (androidInfo.version.sdkInt <= 32 &&
            await Permission.storage.isPermanentlyDenied)) {
      openAppSettings();
    }

    // if (status.isGranted) {
    //   FilePickerResult? result = await FilePicker.platform.pickFiles(
    //     type: FileType.custom,
    //     allowedExtensions: ['pdf'],
    //   );

    //   if (result != null && result.files.isNotEmpty) {
    //     return File(result.files.first.path!);
    //   }
    // }

    return null;
  }

  Future<void> showAddFileDialog(BuildContext context) async {
    channelOptionsController.filePath.value = "";
    channelOptionsController.isFilePaid.value = false;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add PDF File"),
          content: Obx(
            () => SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (channelOptionsController.filePath.value.isEmpty == false)
                    Text(channelOptionsController.filePath.value),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        backgroundColor: CustomColors.primaryColor,
                        foregroundColor: Colors.white),
                    child: Text(
                      'Choose PDF file',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 10.sp),
                    ),
                    onPressed: () async {
                      File? pdfFile = await requestPermissionAndPickPDFFile();
                      if (pdfFile != null) {
                        // setState(() {
                        //   selectedPDF = pdfFile;
                        // });
                        channelOptionsController.filePath.value = pdfFile.path;
                      }
                    },
                  ),
                  if (channelOptionsController.filePath.value.isEmpty == false)
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
                            children: [
                              const Text('Is File Paid'),
                              Switch(
                                value: channelOptionsController.isFilePaid
                                    .value, // Set the initial value as needed
                                onChanged: (value) {
                                  // Handle the switch state change
                                  channelOptionsController.isFilePaid.value =
                                      value;
                                },
                              ),
                            ]),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize:
                                  Size(Get.width * 0.7, Get.height * 0.08),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              backgroundColor: CustomColors.primaryColor,
                              foregroundColor: Colors.white),
                          onPressed: () async {
                            String fileName = fileNameController.text;
                            if (fileName.isNotEmpty) {
                              await channelOptionsController.uploadFile(
                                  title: fileName,
                                  channeId: widget.channel.id!);
                            }
                          },
                          child:
                              channelOptionsController.isUploadingFile.value ==
                                      false
                                  ? Text(
                                      "Upload",
                                      style: TextStyle(fontSize: 12.sp),
                                    )
                                  : const ProgressIndicatorWidget(),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void showAddVideoDialog(BuildContext context) {
    videoTitleTextEditingController.text = '';
    videoUrlcontroller.text = '';
    showDialog(
        context: context,
        builder: (context) => Dialog(
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
                          decoration:
                              const InputDecoration(labelText: 'Video Link'),
                          validator: (value) {
                            // Add your link validation regex here
                            // For example, to require a valid URL:
                            if (!Uri.tryParse(value ?? "")!.isAbsolute ==
                                true) {
                              return 'Please enter a valid URL';
                            }
                            return null;
                          },
                        ),
                        Row(
                          children: <Widget>[
                            const Text('Paid Video:'),
                            Obx(
                              () => Switch(
                                value: channelOptionsController.isVideoPaid
                                    .value, // Set the initial value as needed
                                onChanged: (value) {
                                  // Handle the switch state change
                                  channelOptionsController.isVideoPaid.value =
                                      value;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Obx(
                          () => channelOptionsController.isaddingVideo.value ==
                                  false
                              ? ElevatedButton(
                                  onPressed: () {
                                    validateFieldsAndUpload();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromRGBO(78, 205, 196, 1),
                                    foregroundColor: Color(Colors.white.value),
                                    fixedSize:
                                        Size(Get.width * 0.7, Get.width * 0.1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    // Adjust button size as needed
                                  ),
                                  child: const Text('Upload Video'),
                                )
                              : const ProgressIndicatorWidget(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }

  void showLiveVideoDialog(BuildContext context) {
    videoTitleTextEditingController.text = '';
    videoUrlcontroller.text = '';
    showDialog(
        context: context,
        builder: (context) => Dialog(
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
                        SizedBox(height: Get.height * 0.01),
                        TextFormField(
                          controller: videoTitleTextEditingController,
                          decoration: const InputDecoration(
                              labelText: 'Title',
                              labelStyle: TextStyle(color: Colors.grey)),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a title';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: videoUrlcontroller,
                          decoration: const InputDecoration(
                              labelStyle: TextStyle(color: Colors.grey),
                              labelText: 'Live video link from Youtube'),
                          validator: (value) {
                            // Add your link validation regex here
                            // For example, to require a valid URL:
                            if (!Uri.tryParse(value ?? "")!.isAbsolute ==
                                true) {
                              return 'Please enter a valid URL';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        Text('Choose Date and Time below',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp)),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        Row(
                          children: [
                            ElevatedButton.icon(
                              onPressed: () async {
                                DateTime? selectedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2100),
                                );
                                if (selectedDate != null) {
                                  if (channelOptionsController
                                          .selectedDateTime.value !=
                                      null) {
                                    channelOptionsController
                                            .selectedDateTime.value =
                                        channelOptionsController
                                            .selectedDateTime.value
                                            .copyWith(
                                      year: selectedDate.year,
                                      month: selectedDate.month,
                                      day: selectedDate.day,
                                    );
                                  } else {
                                    channelOptionsController
                                        .selectedDateTime.value = DateTime(
                                      selectedDate.year,
                                      selectedDate.month,
                                      selectedDate.day,
                                    );
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  backgroundColor: CustomColors.primaryColor,
                                  foregroundColor: Colors.white),
                              label: Text(
                                'Choose Date',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10.sp),
                              ),
                              icon: Icon(
                                Icons.calendar_month_rounded,
                                size: 14.sp,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Obx(
                                () => Text(
                                    channelOptionsController
                                                .selectedDateTime.value !=
                                            null
                                        ? DateFormat('yyyy-MM-dd').format(
                                            channelOptionsController
                                                .selectedDateTime.value)
                                        : 'Select a date',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.sp)),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            ElevatedButton.icon(
                              onPressed: () async {
                                TimeOfDay? selectedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                if (selectedTime != null) {
                                  if (channelOptionsController
                                          .selectedDateTime.value !=
                                      null) {
                                    channelOptionsController
                                            .selectedDateTime.value =
                                        channelOptionsController
                                            .selectedDateTime.value
                                            .copyWith(
                                      hour: selectedTime.hour,
                                      minute: selectedTime.minute,
                                    );
                                  } else {
                                    channelOptionsController
                                        .selectedDateTime.value = DateTime(
                                      DateTime.now().year,
                                      DateTime.now().month,
                                      DateTime.now().day,
                                      selectedTime.hour,
                                      selectedTime.minute,
                                    );
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  backgroundColor: CustomColors.primaryColor,
                                  foregroundColor: Colors.white),
                              label: Text(
                                'Choose Time',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10.sp),
                              ),
                              icon: Icon(
                                Icons.schedule_rounded,
                                size: 14.sp,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Obx(
                                () => Text(
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp),
                                  channelOptionsController
                                              .selectedDateTime.value !=
                                          null
                                      ? DateFormat('HH:mm').format(
                                          channelOptionsController
                                              .selectedDateTime.value)
                                      : 'Select a time',
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Get.height * 0.02),
                        Row(
                          children: <Widget>[
                            Text(
                              'Paid Video:',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.sp),
                            ),
                            Obx(
                              () => Switch(
                                value: channelOptionsController.isVideoPaid
                                    .value, // Set the initial value as needed
                                onChanged: (value) {
                                  // Handle the switch state change
                                  channelOptionsController.isVideoPaid.value =
                                      value;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Get.height * 0.01),
                        Obx(
                          () => channelOptionsController
                                      .isaddingLiveVideo.value ==
                                  false
                              ? ElevatedButton(
                                  onPressed: () {
                                    validateFieldsAndUploadLive();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: CustomColors.primaryColor,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    fixedSize: Size(
                                        Get.width * 0.7,
                                        Get.height *
                                            0.08), // Adjust button size as needed
                                  ),
                                  child: const Text('Upload Video'),
                                )
                              : const ProgressIndicatorWidget(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }

  Future<void> validateFieldsAndUpload() async {
    if (_formKey.currentState!.validate()) {
      await channelOptionsController.uploadVideo(
          videoRequestModal: VideoRequestModal(
              title: videoTitleTextEditingController.text,
              link: videoUrlcontroller.text,
              isPaid: channelOptionsController.isVideoPaid.value.toString(),
              type: 'Video',
              channelId: widget.channel.id));

      // Replace with your validation logic.
    }
  }

  bool isThereCurrentDialogShowing(BuildContext context) {
    return ModalRoute.of(context)?.isCurrent != true;
  }

  bool validateFieldsAndUploadLive() {
    if (_formKey.currentState!.validate()) {
      channelOptionsController.uploadLiveVideo(
          videoRequestModal: VideoRequestModal(
              title: videoTitleTextEditingController.text,
              link: videoUrlcontroller.text,
              isPaid: channelOptionsController.isVideoPaid.value.toString(),
              type: 'Video',
              channelId: widget.channel.id));
    }
    return true; // Replace with your validation logic.
  }

  void _handleOptionSelected(String option) {
    switch (option) {
      case "New Notice":
        noticeBottomSheet.showCreateNoticeBottomSheet(
            context: context, channeId: widget.channel.id!);
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
        channelOptionsController.phoneNumber.value = '';
        TextEditingController texteditingController = TextEditingController(
            text: channelOptionsController.phoneNumber.value);
        Get.defaultDialog(
          backgroundColor: Colors.white,
          title: "  Enter phone number of new subscriber  ",
          titleStyle: TextStyle(fontSize: 12.sp),
          content: Obx(
            () => Column(
              children: [
                TextField(
                  controller: texteditingController,
                  keyboardType: TextInputType.phone,
                  onChanged: (value) {
                    channelOptionsController.updatePhoneNumber(value);
                  },
                  decoration: InputDecoration(
                      labelText: "Phone Number",
                      hintStyle: TextStyle(fontSize: 12.sp)),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (channelOptionsController.phoneNumber.value.isNotEmpty) {
                      await channelOptionsController.addSubscriber(
                          channeId: widget.channel.id!);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(Get.width * 0.5, Get.width * 0.1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: CustomColors.primaryColor,
                    elevation: 10,
                  ),
                  child: channelOptionsController.isLoading.value
                      ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(
                            color: CustomColors.primaryColorDark,
                          ),
                        )
                      : Text(
                          "Add Subscriber",
                          style:
                              TextStyle(color: Colors.white, fontSize: 12.sp),
                        ),
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
              },
            )
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
                  backgroundColor:
                      CustomColors.createrColour, // YouTube red color
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
                          fit: BoxFit
                              .cover // Set the height to match the diameter of the CircleAvatar
                          ),
                      errorWidget: (context, url, error) => Image.asset(
                        'assets/default_image.png',
                        fit: BoxFit.cover,
                        // Set the height to match the diameter of the CircleAvatar
                      ),
                      fit: BoxFit.cover,
                    ), /*Image.network(
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
                VideosTab(
                  channelId: widget.channel.id!,
                  createrId: widget.channel.createdBy!,
                ),
                LiveVideosTab(
                  channelId: widget.channel.id!,
                  createrId: widget.channel.createdBy!,
                ),
                // Files Tab Content
                FilesTab(
                    channelId: widget.channel.id!,
                    createrId: widget.channel.createdBy!),
                SubscribersTab(
                    channelId: widget.channel.id!,
                    createrId: widget.channel.createdBy!),
                // About Tab Content
                DescriptionTab(
                    channelId: widget.channel.id!,
                    createrId: widget.channel.createdBy!)
              ],
            ),
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
