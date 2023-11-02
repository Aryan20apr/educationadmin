import 'package:educationadmin/Modals/VideoResourcesModal.dart';
import 'package:educationadmin/screens/common/VideoScreen.dart';
import 'package:educationadmin/screens/pages/Explore2.dart';
import 'package:educationadmin/screens/pages/creator/CreateChannelsController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
class VideosTab extends StatefulWidget {
  const VideosTab({
    super.key,
    required this.channelId,
    required this.createrId
  });
  final int channelId;
  final int createrId;

  @override
  State<VideosTab> createState() => _VideosTabState();
}

class _VideosTabState extends State<VideosTab> {
  final CreaterChannelsController channelsController=Get.put(CreaterChannelsController());
  final _formKey = GlobalKey<FormState>();
    final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  Future<bool>? isFetched;
List<Videos> videos=[];
  // Add this function to handle the pull-to-refresh
  void _onRefresh() async {
    await channelsController.getChannelVideos(channelId: widget.channelId);
    setState(() {
      videos=channelsController.videoData.value.data!.videos??[];
    });
    _refreshController.refreshCompleted(); // Complete the refresh
     _refreshController.loadComplete();
  }

  @override
  void initState()
  {
    super.initState();
    isFetched=channelsController.getChannelVideos(channelId: widget.channelId);
  }
  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
       onRefresh: _onRefresh,
      
      child: FutureBuilder(
        future: isFetched,
        builder: (context,snapshot) {
    
           if(ConnectionState.waiting==snapshot.connectionState)
                  {
                      return const ProgressIndicatorWidget();
                  }
                  else if(ConnectionState.done==snapshot.connectionState)
                  {
                    if(snapshot.data==false)
                    {
                      return const Center(child: Text('Could not obtain videos'),);
                    }
                    else
                    {
                      if(channelsController.videoData.value.data!.videos!.isNotEmpty)
                      {
                        videos=channelsController.videoData.value.data!.videos??[];
                         return Obx(
                           ()=> ListView.builder(
                                     addAutomaticKeepAlives: true,
                                     itemCount: channelsController.videoData.value.data!.videos!.length, // Adjust the number of video items
                                     itemBuilder: (context, index) {
                                       return Card(
                                         margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                         elevation: 4,
                                         child: ListTile(
                                           onTap: () {
                                              Get.to(() => YouTubePlayerScreen(video: videos[index]));
                                           },
                                           contentPadding: const EdgeInsets.all(10),
                                           leading: Image.network(
                                               'https://img.freepik.com/free-photo/multi-color-fabric-texture-samples_1373-434.jpg?t=st=1698132567~exp=1698133167~hmac=4cefa7b45b26f445d5823b41320e1c572ef6a98f6313f54ce351f818b03cc26e'),
                                           title: Text(
                                             '${videos[index].title}',
                                             style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                                           ),
                                           subtitle: const Text('Video Views: 10K'),
                                           trailing: PopupMenuButton<String>(
                                 icon: const Icon(Icons.more_vert, color: Colors.white), // Icon color is green
                                 itemBuilder: (context) {
                                   return <PopupMenuEntry<String>>[
                                     const PopupMenuItem<String>(
                                       value: 'edit',
                                       child: Row(
                                         children: <Widget>[
                                           Icon(Icons.edit, color: Colors.green), // Edit icon is green
                                           SizedBox(width: 8),
                                           Text('Edit', style: TextStyle(color: Colors.green)),
                                         ],
                                       ),
                                     ),
                                     const PopupMenuItem<String>(
                                       value: 'delete',
                                       child: Row(
                                         children: <Widget>[
                                           Icon(Icons.delete, color: Colors.green), // Delete icon is green
                                           SizedBox(width: 8),
                                           Text('Delete', style: TextStyle(color: Colors.green)),
                                         ],
                                       ),
                                     ),
                                   ];
                                 },
                                 onSelected: (value)async {
                                   if (value == 'edit') {
                                    await showEditDialog(context: context,fileName:videos[index].title!,resourceId:  videos[index].id!);
                                     await channelsController.getChannelVideos(channelId: widget.channelId);
                                    setState(() {
                                     videos=channelsController.videoData.value.data!.videos!;
                                    });
                                     print('Edit selected');
                                   } else if (value == 'delete') {
                                     // Handle Delete option
                                     print('Delete selected');
                                     await _showDeleteConfirmationDialog(context:context,resourceId: videos[index].id!);
                                      await channelsController.getChannelVideos(channelId: widget.channelId);
                                      setState(() {
                                        videos = channelsController.videoData.value.data!.videos!;
                                      });
                                   }
                                 },
                               ),
                                         ),
                                       );
                                     },
                                   ),
                         );
                      }
                      else
                      {
                        return const Center(child: Text('No Videos available'),);
                      }
                    }
                  }
                  else
                  {
                    return const ProgressIndicatorWidget();
                  }
         
        }
      ),
    );
  }

Future<void> showEditDialog({required BuildContext context,required String fileName,required int resourceId}) async {
    TextEditingController controller=TextEditingController();
    controller.text=fileName;
    await showDialog(
      barrierDismissible: false,
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
                  onPressed: () async{
                   await validateFieldsAndEdit(videoName: controller.text,resourceId:resourceId);
                  
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: const Size(200, 50), // Adjust button size as needed
                  ),
                  child: const Text('Rename Video'),
                ),
              ],
            ),
          ),
        ),
      ),
    )
              );
      }
  Future<bool> validateFieldsAndEdit({required String videoName,required int resourceId})async
  {
    return await channelsController.editResource(filename:videoName,resourceId: resourceId);
  }
    Future<void> _showDeleteConfirmationDialog({required BuildContext context,required int resourceId}) async{
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
              onPressed:()async
              {
                  channelsController.deleteResource(resourceId:resourceId );
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
