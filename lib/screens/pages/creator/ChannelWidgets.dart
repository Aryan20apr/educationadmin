
import 'package:educationadmin/screens/pages/Explore2.dart';
import 'package:educationadmin/screens/pages/creator/CreateChannelsController.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import '../../../Modals/FileResourcesModal.dart';
import '../../../Modals/VideoResourcesModal.dart';
import '../../common/PdfView.dart';
import '../../common/VideoScreen.dart';
class DescriptionTab extends StatelessWidget {
  const DescriptionTab({
    super.key,
    required this.channelId,
    required this.createrId
  });
final int channelId;
final int createrId;
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'About Channel',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Channel Name',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('100K subscribers'),
            SizedBox(height: 16),
            Text(
              'Description:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'This is a channel description. You can add a brief description of your channel and what it is about.',
            ),
            SizedBox(height: 16),
            Text(
              'Contact Information:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('Email: channel@example.com'),
            Text('Website: www.example.com'),
          ],
        ),
      ),
    ));
  }
}

class SubscribersTab extends StatelessWidget {
  const SubscribersTab({
    super.key,
    required this.channelId,
    required this.createrId
  });
 final int channelId;
 final int createrId;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10, // Adjust the number of subscribers

      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          elevation: 4,
          child: ListTile(
            onTap: () {},
            contentPadding: const EdgeInsets.all(10),
            leading: const CircleAvatar(
              radius: 30, // Adjust the radius as needed

              backgroundImage: NetworkImage(
                'https://example.com/subscriber_profile.jpg', // Replace with the actual subscriber's profile image URL
              ),
            ),
            title: Text(
              'Subscriber Name $index',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }
}

class FilesTab extends StatefulWidget {
  const FilesTab({
    super.key,
    required this.channelId,
    required this.createrId
  });
 final int channelId;
  final int createrId;

  @override
  State<FilesTab> createState() => _FilesTabState();
}

class _FilesTabState extends State<FilesTab> {
  final CreaterChannelsController channelsController=Get.put(CreaterChannelsController());
  Future<bool>? isFetched;

  @override
  void initState()
  {
    super.initState();
    isFetched=channelsController.getChannelFiles(channelId: widget.channelId);
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:isFetched,
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
                       List<Files>? files=channelsController.fileData.value.data!.files;
                        return ListView.builder(
        
          itemCount: channelsController.fileData.value.data!.files!.length, // Adjust the number of file items
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              elevation: 4,
              child: ListTile(
                onTap: () { Get.to(()=>PdfView(file: files[index]));},
                contentPadding: const EdgeInsets.all(10),
                leading: Image.network(
                  'https://img.freepik.com/free-photo/clipboard-with-checklist-paper-note-icon-symbol-purple-background-3d-rendering_56104-1491.jpg?w=826&t=st=1698135465~exp=1698136065~hmac=cadd6ad00463dcae2be4df14c42d6b256a018d075562de67de8327ad7cadd052', // Replace with the actual file thumbnail URL
                  width: 80, // Adjust the thumbnail size as needed
                ),
                title: Text(
                  '${files![index].title}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                subtitle:  Text(
                    '${files[index].description}'), // You can display file size or other information here
                trailing: const Icon(Icons.arrow_forward),
              ),
            );
          },
        );
                    }
                    else
                    {
                      return const Center(child: Text('No Files available'),);
                    }
                  }
                }
                else
                {
                  return const ProgressIndicatorWidget();
                }
       
      }
    );
  }
}

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
  Future<bool>? isFetched;
  @override
  void initState()
  {
    super.initState();
    isFetched=channelsController.getChannelVideos(channelId: widget.channelId);
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
                       List<Videos> videos=channelsController.videoData.value.data!.videos??[];
                       return ListView.builder(
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
                trailing: const Icon(Icons.more_vert_rounded),
              ),
            );
          },
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
    );
  }
}