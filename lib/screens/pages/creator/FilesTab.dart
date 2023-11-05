import 'package:educationadmin/Modals/FileResourcesModal.dart';
import 'package:educationadmin/screens/common/PdfView.dart';
import 'package:educationadmin/screens/pages/Explore2.dart';
import 'package:educationadmin/screens/pages/creator/CreateChannelsController.dart';
import 'package:educationadmin/utils/ColorConstants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';
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
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  Future<bool>? isFetched;
List<Files> files=[];
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
            physics: const NeverScrollableScrollPhysics(),
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
void onRefresh() async {
   bool result= await channelsController.getChannelFiles(channelId: widget.channelId);
    setState(() {
      files=channelsController.fileData.value.data!.files??[];
      isFetched=Future.delayed(Duration.zero,()=>result);
    });
    _refreshController.refreshCompleted(); // Complete the refresh
     _refreshController.loadComplete();
  }
  @override
  void initState()
  {
    super.initState();
    isFetched=channelsController.getChannelFiles(channelId: widget.channelId);
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
       onRefresh:onRefresh,
      controller: _refreshController,
      child: FutureBuilder(
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
                        files=channelsController.fileData.value.data!.files??[];
                          return Obx(
                            ()=> ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                    itemCount: channelsController.fileData.value.data!.files!.length, // Adjust the number of file items
                                    itemBuilder: (context, index) {
                                      return Card(
                                        color: CustomColors.tileColour,
                                        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                        elevation: 4,
                                        child: ListTile(
                                          onTap: () { Get.to(()=>PdfView(file: files![index]));},
                                          contentPadding: const EdgeInsets.all(10),
                                          leading: CachedNetworkImage(
                                colorBlendMode: BlendMode.darken,
                                                imageUrl: 'https://img.freepik.com/free-photo/clipboard-with-checklist-paper-note-icon-symbol-purple-background-3d-rendering_56104-1491.jpg?w=826&t=st=1698135465~exp=1698136065~hmac=cadd6ad00463dcae2be4df14c42d6b256a018d075562de67de8327ad7cadd052',
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
                                              ),
                                          title: Text(
                                            '${files![index].title}',
                                            style:  TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold,color: CustomColors.secondaryColor),
                                          ),
                                          // You can display file size or other information here
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
      ),
    );
  }
}
