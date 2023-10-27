
import 'package:educationadmin/Modals/UserModal.dart';
import 'package:educationadmin/screens/pages/Explore2.dart';
import 'package:educationadmin/screens/pages/creator/ChannelOptionController.dart';
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

class SubscribersTab extends StatefulWidget {
   const SubscribersTab({
    super.key,
    required this.channelId,
    required this.createrId
  });
 final int channelId;
 final int createrId;

  @override
  State<SubscribersTab> createState() => _SubscribersTabState();
}

class _SubscribersTabState extends State<SubscribersTab> {
  late Future<bool> consumers;
  CreaterChannelsController controller=Get.put(CreaterChannelsController());
  @override
  void initState()
  {
    super.initState();
    consumers=controller.getChannelSubscribers(channelId: widget.channelId);
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future:consumers,
      builder: (context,snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting)
        {
          return const ProgressIndicatorWidget();
        }
        else if(snapshot.hasError)
        {
          return const Center(child:Text('Some error occured'));
        }
        else if(ConnectionState.done==snapshot.connectionState)
        {
          if(snapshot.hasData&&snapshot.data==false) {
            return const Center(child: Text("No subscribers"));
          }
          else {
            if(controller.consumerList.value.consumers!.isEmpty) {
              return const Center(child: Text("No subscribers"));
            } else {
              return ListView.builder(
            itemCount: controller.consumerList.value.consumers!.length, // Adjust the number of subscribers
          
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
                    '${controller.consumerList.value.consumers![index].name}',
                    style:  TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                  ),
                  subtitle:Text(
                    '${controller.consumerList.value.consumers![index].phone}',
                    style:  TextStyle(fontSize: 12.sp, ),
                  
                  ) ,
                  trailing: PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert, color: Colors.black), // Icon color is green
      itemBuilder: (context) {
        return <PopupMenuEntry<String>>[
          
          const PopupMenuItem<String>(
            value: 'delete',
            child: Row(
              children: <Widget>[
                Icon(Icons.delete, color: Colors.green), // Delete icon is green
                SizedBox(width: 8),
                Text('Remove Subscriber', style: TextStyle(color: Colors.green)),
              ],
            ),
          ),
        ];
      },
      onSelected: (value) {
         if (value == 'delete') {
          // Handle Delete option
          print('Delete selected');
          _showDeleteConfirmationDialog(context);
        }
      },
    ),
                ),
              );
            },
          );
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

Future<void> _showDeleteConfirmationDialog(BuildContext context) async{
   await showDialog(
      
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          
          title: const Text('Delete Confirmation'),
          content: const Text('Are you sure you want to delete this subscriber?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
               
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              onPressed:() async{
                                    // Handle Delete
                                     // Handle Cancel
                                    
                              // bool result=    await controller.deleteSubscriber(channelId:createrChannelsController.channelData.value.channels![index].id!);
                              //       if(result)
                              //       {
                              //         Get.showSnackbar(const GetSnackBar(message:'Channel Deleted successfully',duration: Duration(seconds:3),));
                              //         setState(() {
                              //           createrChannelsController.channelData.value.channels!.remove(createrChannelsController.channelData.value.channels![index]);
                              //         });
                              //       }
                              //       else{
                              //         Get.showSnackbar(const GetSnackBar(message:'Channel could not be deleted successfully',duration: Duration(seconds:3),));
                              //       }
                                 
                              //    Navigator.of(context).pop();
                                    
                              //       // Perform the delete operation
                              //       print('Item deleted');
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
 final _formKey = GlobalKey<FormState>();
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
                  "Reanme file",
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
                  child: const Text('Rename file'),
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
          content: const Text('Are you sure you want to delete this file?'),
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
                    return const Center(child: Text('Could not obtain files'),);
                  }
                  else
                  {
                    if(channelsController.fileData.value.data!.files!.isNotEmpty)
                    {
                       List<Files>? files=channelsController.fileData.value.data!.files;
                        return Obx(
                          ()=> ListView.builder(
                                
                                  itemCount: channelsController.fileData.value.data!.files!.length, // Adjust the number of file items
                                  itemBuilder: (context, index) {
                                    return Card(
                                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                      elevation: 4,
                                      child: ListTile(
                                        onTap: () { Get.to(()=>PdfView(file: files![index]));},
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
                                            '${files![index].description}'), // You can display file size or other information here
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
                                 await showEditDialog(context: context,fileName:files![index].title!,resourceId:  files![index].id!);
                                  await channelsController.getChannelFiles(channelId: widget.channelId);
                                 setState(() {
                                  files=channelsController.fileData.value.data!.files!;
                                 });
                                  print('Edit selected');
                                } else if (value == 'delete') {
                                  // Handle Delete option
                                  print('Delete selected');
                                 await _showDeleteConfirmationDialog(context:context,resourceId: files![index].id!);
                                   await channelsController.getChannelFiles(channelId: widget.channelId);
                                   setState(() {
                                     files = channelsController.fileData.value.data!.files!;
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
  final _formKey = GlobalKey<FormState>();
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
