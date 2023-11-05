


import 'package:educationadmin/Modals/VideoResourcesModal.dart';
import 'package:educationadmin/screens/common/VideoScreen.dart';
import 'package:educationadmin/screens/pages/Explore2.dart';
import 'package:educationadmin/utils/ColorConstants.dart';

import 'package:educationadmin/utils/Controllers/ChanneResourcelController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';






class VideoResourcesTab extends StatefulWidget {
 const VideoResourcesTab({Key? key, required this.channelId}) : super(key: key);
  final int channelId;

  @override
  State<VideoResourcesTab> createState() => _VideoResourcesTabState();
}

class _VideoResourcesTabState extends State<VideoResourcesTab> {
  ChannelResourceController resourceController = Get.put(ChannelResourceController());
  Future<bool>? isFetched;
  final RefreshController refreshController=RefreshController();
  @override
  void initState()
  {
    isFetched=resourceController.getChannelVideos(channelId: widget.channelId);
    super.initState();
  }
void onRefresh() async {
   bool result= await resourceController.getChannelVideos(channelId: widget.channelId);
    setState(() {
      isFetched=Future.delayed(Duration.zero,()=>result);
    });
    refreshController.refreshCompleted(); // Complete the refresh
     refreshController.loadComplete();
  }
  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      onRefresh: onRefresh,
      controller: refreshController,
      child: ListView(
        children:[ Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: FutureBuilder(
            future: isFetched,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: ProgressIndicatorWidget()),
                  ),
                );
              } else if (snapshot.hasError) {
                Logger().i(snapshot.error);
                return const Center(
                  child: Text('Could not obtain videos'),
                );
              } else {
                if (resourceController.videoData.value.data == null) {
                  return const Center(
                    child: Text('No Files Available'),
                  );
                }
                Data? data = resourceController.videoData.value.data;
          
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data!.videos!.length,
                  itemBuilder: (context, index) {
                    List<Videos>? videos = data.videos;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        
                        onTap: () {
                          Get.to(() => YouTubePlayerScreen(video: videos[index]));
                        },
                        style: ListTileStyle.list,
                        enableFeedback: true,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        tileColor: CustomColors.tileColour,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        leading: Container(
                         
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            gradient: _buildTileGradient(), // Use the custom gradient
                          ),
                          child: const Icon(Icons.video_file_rounded, color: CustomColors.secondaryColor),
                        ),
                        title: Text(
                          "${videos![index].title}",
                          style: const TextStyle(color: CustomColors.secondaryColor, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Row(
                          children: <Widget>[
                            const Icon(Icons.linear_scale, color: CustomColors.accentColor),
                            Text(
                              videos[index].description ?? "",
                              style: const TextStyle(color: CustomColors.secondaryColor),
                            )
                          ],
                        ),
                        trailing: Icon(Icons.arrow_circle_right_outlined,color: CustomColors.accentColor,),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),]
      ),
    );
  }

  // Define the custom gradient for the ListTile
  LinearGradient _buildTileGradient() {
    // Use multiple colors in the gradient
    return LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Colors.red,
        Colors.orange,
        Colors.yellow,
      ],
    );
  }
}
