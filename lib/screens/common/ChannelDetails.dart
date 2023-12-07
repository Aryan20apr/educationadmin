

import 'package:educationadmin/Modals/ChannelListModal.dart';
import 'package:educationadmin/utils/ColorConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'Tab1.dart';
import 'Tab2.dart';

class ChannelDetails extends StatefulWidget {
  Channels channel;
   ChannelDetails({super.key,required this.channel});

  @override
  State<ChannelDetails> createState() => _ChannelDetailsState();
}

class _ChannelDetailsState extends State<ChannelDetails>  with SingleTickerProviderStateMixin{
   late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
bool _isSearchBarOpen = false;
  final TextEditingController _searchBarController = TextEditingController();

  void _toggleSearchBar() {
    setState(() {
      _isSearchBarOpen = !_isSearchBarOpen;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title:  Text(widget.channel.name!),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
          
            Container(
              color: CustomColors.secondaryColor.withOpacity(1),
              width: Get.width,
              child: Padding(
                padding: const EdgeInsets.only(left:10.0,right: 10.0,top: 10.0),
                child: Container(
                  
                  // height: 50,
                  
                  decoration: BoxDecoration(
                      color:Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20)),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: TabBar(
                    indicatorPadding:const EdgeInsets.all(0),
                    
                    onTap: (index){
                      setState(() {
                        tabController.index=index;
                      });
                    },
                    labelPadding: EdgeInsets.zero,
                    unselectedLabelColor: Colors.black,
                    labelColor: CustomColors.accentColor,
                    indicatorColor: CustomColors.primaryColorDark,
                    splashBorderRadius: BorderRadius.circular(20),
                    indicator: BoxDecoration(                    color: CustomColors.primaryColorDark,
                        borderRadius:BorderRadius.circular(20)
                    ),
                    controller: tabController,
                    tabs: const [
                      Tab(
                         child: Center(child: Text('Videos')),
                      ),
                      Tab(
                        child: Center(child: Text('Files')),
                      ),
                        
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  
                   VideoResourcesTab(channelId: widget.channel.id!,),
                  FileResourcesTab(channelId: widget.channel.id!,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}
class _CustomClipper extends CustomClipper<Rect> {
  final int _index;

  _CustomClipper(this._index);

  @override
  Rect getClip(Size size) {
    if (_index == 0) {
      // Clip from the right
      return Rect.fromLTWH(0.0, 0.0, size.width - 10.0, size.height);
    } else {
      // Clip from the left
      return Rect.fromLTWH(10.0, 0.0, size.width, size.height);
    }
  }

  @override
  bool shouldReclip(_CustomClipper oldClipper) => _index != oldClipper._index;
}
