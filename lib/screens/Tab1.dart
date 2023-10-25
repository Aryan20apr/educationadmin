


import 'package:educationadmin/Modals/VideoResourcesModal.dart';
import 'package:educationadmin/screens/VideoScreen.dart';
import 'package:educationadmin/utils/Controllers/ChanneResourcelController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';


// class VideoResourcesTab extends StatefulWidget {
//    VideoResourcesTab({super.key,required this.channelId});
//   final int channelId;

//   @override
//   State<VideoResourcesTab> createState() => _VideoResourcesTabState();
// }

// class _VideoResourcesTabState extends State<VideoResourcesTab> {
//   ChannelResourceController resourceController = Get.put(ChannelResourceController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
      
//       body: Padding(
//         padding: const EdgeInsets.only(top:10.0),
//         child: FutureBuilder(
//           future:resourceController.getChannelVideos(channelId: widget.channelId),
//           builder: (context,snapshot) {
           
//              if(snapshot.connectionState==ConnectionState.waiting)
//             {
//            return  Center(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Center(child: SizedBox(height: Get.height*0.05,child: const CircularProgressIndicator())),
//       ),
//     );
//             }
            
//             else if(snapshot.hasError){
//               Logger().i(snapshot.error);
//               return const Center(child: Text('Could not obtain videos'),);
//             }
//             else
//             {
//                if(resourceController.videoData.value.data==null) {
                
//                 return const Center(child: Text('No Files Available'),);
//               }
//               Data? data =resourceController.videoData.value.data;
              
//               return ListView.builder(
//               itemCount: data!.videos!.length,
//               itemBuilder: (context, index) {
                
//                 List<Videos>? videos=data.videos;
//                 //FileDownloadStatusController fileController=Get.put(FileDownloadStatusController(),tag: files![index].title);
//                 //fileController.checkFileDownloadStatus(filename:files[index].title!);
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(vertical:8.0),
//                   child: ListTile(
//                     onTap: (){
//                        Get.to(()=>YouTubePlayerScreen(video: videos![index]));
//                     },
//                     style: ListTileStyle.list,
//                     enableFeedback: true,
//                     shape: RoundedRectangleBorder(borderRadius:  BorderRadius.circular(20)),
//                     tileColor: Colors.purple.shade100,
//                           contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
//                           leading: Container(
//                   padding: const EdgeInsets.only(right: 12.0),
//                   decoration: const BoxDecoration(
//                       border: Border(
//                           right: BorderSide(width: 1.0, color: Colors.white24))),
//                   child: const Icon(Icons.picture_as_pdf, color: Colors.white),
//                           ),
//                           title: Text(
//                   "${videos![index].title}",
//                   style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                           ),
//                           // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
                      
//                           subtitle:  Row(
//                   children: <Widget>[
//                     const Icon(Icons.linear_scale, color: Colors.yellowAccent),
//                     Text(videos![index].description??"", style: const TextStyle(color: Colors.white))
//                   ],
//                           ),
//                           trailing: Icon(Icons.arrow_circle_right_outlined)
//                 )
//                 );
//               },
//             );
//             }
//           }
//         ),
//       ),
//     );
//   }
// }




class VideoResourcesTab extends StatefulWidget {
 const VideoResourcesTab({Key? key, required this.channelId}) : super(key: key);
  final int channelId;

  @override
  State<VideoResourcesTab> createState() => _VideoResourcesTabState();
}

class _VideoResourcesTabState extends State<VideoResourcesTab> {
  ChannelResourceController resourceController = Get.put(ChannelResourceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: FutureBuilder(
          future: resourceController.getChannelVideos(channelId: widget.channelId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(child: SizedBox(height: Get.height * 0.05, child: const CircularProgressIndicator())),
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
                      tileColor: Colors.purple.shade100,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      leading: Container(
                        padding: const EdgeInsets.only(right: 12.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          gradient: _buildTileGradient(), // Use the custom gradient
                        ),
                        child: const Icon(Icons.picture_as_pdf, color: Colors.white),
                      ),
                      title: Text(
                        "${videos![index].title}",
                        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Row(
                        children: <Widget>[
                          const Icon(Icons.linear_scale, color: Colors.yellowAccent),
                          Text(
                            videos![index].description ?? "",
                            style: const TextStyle(color: Colors.black),
                          )
                        ],
                      ),
                      trailing: Icon(Icons.arrow_circle_right_outlined),
                    ),
                  );
                },
              );
            }
          },
        ),
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
