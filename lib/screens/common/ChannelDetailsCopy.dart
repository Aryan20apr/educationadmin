import 'package:educationadmin/Modals/ChannelListModal.dart';
import 'package:educationadmin/utils/ColorConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'Tab1.dart';
import 'Tab2.dart';

class ChannelDetailsCopy extends StatefulWidget {
  final Channels channel;

 const ChannelDetailsCopy({Key? key, required this.channel}) : super(key: key);

  @override
  State<ChannelDetailsCopy> createState() => _ChannelDetailsCopyState();
}

class _ChannelDetailsCopyState extends State<ChannelDetailsCopy>
    with SingleTickerProviderStateMixin {
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
        title: Text(widget.channel.name!),
      ),
      body: Column(
        children: [
          Container(
            color: CustomColors.secondaryColor.withOpacity(1),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200.withOpacity(1),
                  borderRadius: BorderRadius.circular(20),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: TabBar(
                  indicatorPadding: const EdgeInsets.all(0),
                  onTap: (index) {
                    setState(() {
                      tabController.index = index;
                    });
                  },
                  labelPadding: EdgeInsets.zero,
                  unselectedLabelColor: Colors.black,
                  labelColor: Colors.black,
                  indicatorColor: CustomColors.accentColor,
                  splashBorderRadius: BorderRadius.circular(20),
                  indicator: BoxDecoration(
                    color: CustomColors.accentColor,
                    borderRadius: BorderRadius.circular(20),
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
                VideoResourcesTab(channelId: widget.channel.id!),
                FileResourcesTab(channelId: widget.channel.id!),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
