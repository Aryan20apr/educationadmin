

import 'package:educationadmin/Modals/ChannelListModal.dart';
import 'package:educationadmin/screens/Tab1.dart';
import 'package:educationadmin/screens/Tab2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:  Text(widget.channel.name!),
      ),
      body: Padding(
        padding:const EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(height: Get.height*0.05),
              Container(
                
                // height: 50,
                width: Get.width*0.8,
                decoration: BoxDecoration(
                    color:Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20)),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                child: TabBar(
                  indicatorPadding: EdgeInsets.all(0),
                  
                  onTap: (index){
                    setState(() {
                      tabController.index=index;
                    });
                  },
                  labelPadding: EdgeInsets.zero,
                  unselectedLabelColor: Colors.black,
                  labelColor: Colors.black,
                  indicatorColor: Colors.purple.shade100,
                  splashBorderRadius: BorderRadius.circular(20),
                  indicator: BoxDecoration(                    color: Colors.purple.shade100,
                      borderRadius:BorderRadius.circular(20)
                  ),
                  controller: tabController,
                  tabs: const [
                    Tab(
                       child: Center(child: Text('Videos')),
                    ),
                    Tab(
                      child: Center(child: Text('Resources')),
                    ),
                      
                  ],
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
