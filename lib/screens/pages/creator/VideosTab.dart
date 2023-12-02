import 'package:educationadmin/Modals/VideoResourcesModal.dart';
import 'package:educationadmin/screens/common/PodVideoScreen.dart';
import 'package:educationadmin/screens/common/VideoScreen.dart';
import 'package:educationadmin/screens/pages/Explore2.dart';
import 'package:educationadmin/screens/pages/creator/CreateChannelsController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../utils/ColorConstants.dart';
import '../../../widgets/ProgressIndicatorWidget.dart';

class VideosTab extends StatefulWidget {
  const VideosTab(
      {super.key, required this.channelId, required this.createrId});
  final int channelId;
  final int createrId;

  @override
  State<VideosTab> createState() => _VideosTabState();
}

class _VideosTabState extends State<VideosTab> {
  final CreaterChannelsController channelsController =
      Get.put(CreaterChannelsController());
  final _formKey = GlobalKey<FormState>();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  ScrollController scrollController=ScrollController();
  Future<bool>? isFetched;
  List<Videos> videos = [];
  // Add this function to handle the pull-to-refresh
  void _onRefresh() async {
    bool result =
        await channelsController.getChannelVideos(channelId: widget.channelId);
    setState(() {
      isFetched = Future.delayed(Duration.zero, () => result);
      videos = channelsController.normalVideos;
    });
    _refreshController.refreshCompleted(); // Complete the refresh
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    super.initState();
    isFetched =
        channelsController.getChannelVideos(channelId: widget.channelId);
      scrollController.addListener(_scrollListener);
  }
 @override
  void dispose() {
    scrollController.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (scrollController.offset <= scrollController.position.minScrollExtent-60 &&
        !_refreshController.isRefresh) {
      // User has reached the top, and not currently refreshing
      _refreshController.requestRefresh();
    }
  }
  @override
  Widget build(BuildContext context) {
    return NotificationListener(
  //     onNotification: (ScrollNotification scrollInfo) {
  //   if (scrollInfo.metrics.pixels == 0.0 &&
  //       scrollInfo is ScrollUpdateNotification &&
  //       scrollInfo.dragDetails != null &&
  //       scrollInfo.dragDetails!.primaryDelta! > 0) {
  //     // The user has scrolled to the top and is pulling down
  //     _refreshController.requestRefresh();
  //   }
  //   return false;
  // },
    onNotification: (ScrollNotification scrollInfo) {
         scrollController.position.copyWith();
        return false;
      },
      child: SmartRefresher(
        controller: _refreshController,
        onRefresh: _onRefresh,
        child: SafeArea(
          maintainBottomViewPadding: true,
          child: FutureBuilder(
              future: isFetched,
              builder: (context, snapshot) {
                if (ConnectionState.waiting == snapshot.connectionState) {
                  return const ProgressIndicatorWidget();
                } else if (ConnectionState.done == snapshot.connectionState) {
                  if (snapshot.data == false) {
                    return const Center(
                      child: Text('Could not obtain videos'),
                    );
                  } else {
                    if (channelsController
                        .videoData.value.data!.videos!.isNotEmpty) {
                      videos = channelsController.normalVideos;
                      return Obx(
                        () => 
                        CustomScrollView(
                          controller: scrollController,
                          physics:const BouncingScrollPhysics(),
                          slivers: [
                            SliverList(delegate: SliverChildBuilderDelegate(
                              childCount:channelsController.normalVideos.length,
                              (context, index) {
                                  return Card(
                              color: CustomColors.tileColour,
                              shape: const BeveledRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              elevation: 4,
                              child: ListTile(
                                style: ListTileStyle.list,
                                //tileColor:CustomColors.tileColour,
                                onTap: () {
                                  Get.to(() => PodYouTubePlayerScreen(
                                      video: videos[index]));
                                },
                                contentPadding: const EdgeInsets.all(10),
                                leading: CachedNetworkImage(
                                  colorBlendMode: BlendMode.darken,
                                  imageUrl:
                                      'https://img.freepik.com/free-photo/multi-color-fabric-texture-samples_1373-434.jpg?t=st=1698132567~exp=1698133167~hmac=4cefa7b45b26f445d5823b41320e1c572ef6a98f6313f54ce351f818b03cc26e',
                                  placeholder: (context, url) => Image.asset(
                                      'assets/default_image.png',
                                      fit: BoxFit
                                          .cover // Set the height to match the diameter of the CircleAvatar
                                      ),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    'assets/default_image.png',
                                    fit: BoxFit.cover,
                                    // Set the height to match the diameter of the CircleAvatar
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                title: Text(
                                  '${videos[index].title}',
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                      color: CustomColors.secondaryColor),
                                ),
          
                                trailing: PopupMenuButton<String>(
                                  icon: const Icon(Icons.more_vert,
                                      color: Colors.white), // Icon color is green
                                  itemBuilder: (context) {
                                    return <PopupMenuEntry<String>>[
                                      const PopupMenuItem<String>(
                                        value: 'edit',
                                        child: Row(
                                          children: <Widget>[
                                            Icon(Icons.edit,
                                                color: CustomColors
                                                    .primaryColorDark), // Edit icon is green
                                            SizedBox(width: 8),
                                            Text('Edit',
                                                style: TextStyle(
                                                    color: CustomColors
                                                        .primaryColorDark)),
                                          ],
                                        ),
                                      ),
                                      const PopupMenuItem<String>(
                                        value: 'delete',
                                        child: Row(
                                          children: <Widget>[
                                            Icon(Icons.delete,
                                                color: CustomColors
                                                    .primaryColorDark), // Delete icon is green
                                            SizedBox(width: 8),
                                            Text('Delete',
                                                style: TextStyle(
                                                    color: CustomColors
                                                        .primaryColorDark)),
                                          ],
                                        ),
                                      ),
                                    ];
                                  },
                                  onSelected: (value) async {
                                    if (value == 'edit') {
                                      await showEditDialog(
                                          context: context,
                                          fileName: videos[index].title!,
                                          resourceId: videos[index].id!);
                                      await channelsController.getChannelVideos(
                                          channelId: widget.channelId);
                                      setState(() {
                                        videos = channelsController.normalVideos;
                                      });
                                      print('Edit selected');
                                    } else if (value == 'delete') {
                                      // Handle Delete option
                                      print('Delete selected');
                                      await _showDeleteConfirmationDialog(
                                          context: context,
                                          resourceId: videos[index].id!);
                                      await channelsController.getChannelVideos(
                                          channelId: widget.channelId);
                                      setState(() {
                                        videos = channelsController.normalVideos;
                                      });
                                    }
                                  },
                                ),
                              ),
                            );
                            }))
                          ],
                        )
                        // ListView.builder(
                        //   //physics: const NeverScrollableScrollPhysics(),
                        //   addAutomaticKeepAlives: true,
                        //   itemCount: channelsController.normalVideos
                        //       .length, // Adjust the number of video items
                        //   itemBuilder: (context, index) {
                            
                        //   },
                        // ),
                      );
                    } else {
                      return const Center(
                        child: Text('No Videos available'),
                      );
                    }
                  }
                } else {
                  return const ProgressIndicatorWidget();
                }
              }),
        ),
      ),
    );
  }

  Future<void> showEditDialog(
      {required BuildContext context,
      required String fileName,
      required int resourceId}) async {
    TextEditingController controller = TextEditingController();
    controller.text = fileName;
    await showDialog(
        barrierDismissible: false,
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
                          "Reanme video",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: controller,
                          decoration: const InputDecoration(labelText: 'Title'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a title';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () async {
                            await validateFieldsAndEdit(
                                videoName: controller.text,
                                resourceId: resourceId);
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            minimumSize: const Size(
                                200, 50), // Adjust button size as needed
                          ),
                          child: const Text('Rename Video'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }

  Future<bool> validateFieldsAndEdit(
      {required String videoName, required int resourceId}) async {
    return await channelsController.editResource(
        filename: videoName, resourceId: resourceId);
  }

  Future<void> _showDeleteConfirmationDialog(
      {required BuildContext context, required int resourceId}) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Confirmation'),
          content: const Text('Are you sure you want to delete this video?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              onPressed: () async {
                channelsController.deleteResource(resourceId: resourceId);
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
