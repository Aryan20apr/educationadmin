import 'package:educationadmin/Modals/FileResourcesModal.dart';
import 'package:educationadmin/screens/pages/Explore2.dart';
import 'package:educationadmin/utils/ColorConstants.dart';
import 'package:educationadmin/utils/Controllers/ChanneResourcelController.dart';
import 'package:educationadmin/utils/Controllers/FileDownloadStatusController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../widgets/ProgressIndicatorWidget.dart';
import 'PdfView.dart';


class FileResourcesTab extends StatefulWidget {
   const FileResourcesTab({super.key,required this.channelId});
  final int channelId;

  @override
  State<FileResourcesTab> createState() => _FileResourcesTabState();
}

class _FileResourcesTabState extends State<FileResourcesTab> {
  ChannelResourceController resourceController = Get.put(ChannelResourceController());
 Future<bool>? isFetched;
  final RefreshController refreshController=RefreshController();
  @override
  void initState()
  {
    isFetched=resourceController.getChannelFiles(channelId: widget.channelId);
    super.initState();
  }
void onRefresh() async {
   bool result= await resourceController.getChannelFiles(channelId: widget.channelId);
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
          children: [Padding(
            padding: const EdgeInsets.only(top:10.0),
            child: FutureBuilder(
              future:resourceController.getChannelFiles(channelId: widget.channelId),
              builder: (context,snapshot) {
               
                 if(snapshot.connectionState==ConnectionState.waiting)
                {
               return  const Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(child: ProgressIndicatorWidget()),
          ),
            );
                }
                else if(snapshot.hasError){
                  return Center(child: Text(snapshot.error.toString()),);
                }
                else
                {
                  if(resourceController.fileData.value.data==null||resourceController.fileData.value.data!.files!.isEmpty) {
                    return const Center(child: Text('No Files Available'),);
                  }
                  Data? data =resourceController.fileData.value.data;
                  
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  itemCount: data!.files!.length,
                  itemBuilder: (context, index) {
                    
                    List<Files>? files=data.files;
                    FileController fileController=Get.put(FileController(),tag: files![index].link);
                    fileController.checkFileDownloadStatus(filename:files[index].title!,createdAt: files[index].createdAt!);
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical:8.0),
                      child: ListTile(
                        onTap: (){
                           Get.to(()=>PdfView(file: files[index]));
                        },
                        style: ListTileStyle.list,
                        enableFeedback: true,
                        shape: RoundedRectangleBorder(borderRadius:  BorderRadius.circular(20)),
                        tileColor: CustomColors.tileColour,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                              leading: Container(
                      padding: const EdgeInsets.only(right: 12.0),
                      decoration: const BoxDecoration(
                          border: Border(
                              right: BorderSide(width: 1.0, color: Colors.white24))),
                      child: const Icon(Icons.picture_as_pdf, color: CustomColors.accentColor),
                              ),
                              title: Text(
                      "${files[index].title}",
                      style: const TextStyle(color: CustomColors.secondaryColor, fontWeight: FontWeight.bold),
                              ),
                              // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
                          
                              subtitle:  Row(
                      children: <Widget>[
                        const Icon(Icons.linear_scale, color: Colors.yellowAccent),
                        Text(files[index].description??"", style: const TextStyle(color: Colors.white))
                      ],
                              ),
                              trailing: Obx(()=>(fileController.isDownloading.value? LoadingAnimationWidget.threeArchedCircle(color: Colors.white, size: Get.width*0.05):IconButton(onPressed: () {
                               fileController.isDownloaded.value==false?fileController.downloadFile(file:files[index]): fileController.deleteFile(name:files[index].title!,createdAt: files[index].createdAt!);
                              }
                              ,icon: Obx(() => Icon(fileController.isDownloaded.value? Icons.check_circle_outline_rounded:Icons.download, color: CustomColors.accentColor,),)))),
                    )
                    );
                  },
                );
                }
              }
            ),
          ),]
        ),
     );
    
  }
}