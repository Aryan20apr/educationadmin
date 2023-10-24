import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
class CreatorChannel extends StatefulWidget {
  const CreatorChannel({super.key});

  @override
  State<CreatorChannel> createState() => _CreatorChannelState();
}

class _CreatorChannelState extends State<CreatorChannel> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                foregroundColor: Colors.white,
                expandedHeight: Get.height*0.25,
                pinned: true,
                floating: false,
                backgroundColor: Colors.red, // YouTube red color
                flexibleSpace: FlexibleSpaceBar(
                  
                  centerTitle: true,
                  title: Text(
                    "Channel Name",
                    style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold,color: Colors.white),
                  ),
                  background: Image.network(
                    'https://img.freepik.com/free-photo/multi-color-fabric-texture-samples_1373-434.jpg?t=st=1698132567~exp=1698133167~hmac=4cefa7b45b26f445d5823b41320e1c572ef6a98f6313f54ce351f818b03cc26e',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverPersistentHeader(
                
                delegate: _SliverAppBarDelegate(
                  const TabBar(
                    labelColor: Colors.red,
                    indicatorColor: Colors.red, // YouTube red color
                    tabs: [
                      Tab(text: 'Videos'),
                      Tab(text: 'Files'),
                      Tab(text: 'About'),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            children:  [
              // Videos Tab Content
              ListView.builder(
                addAutomaticKeepAlives: true,
                itemCount: 10, // Adjust the number of video items
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    elevation: 4,
                    child: ListTile(
                      onTap: () {},
                      contentPadding: const EdgeInsets.all(10),
                      leading: Image.network('https://img.freepik.com/free-photo/multi-color-fabric-texture-samples_1373-434.jpg?t=st=1698132567~exp=1698133167~hmac=4cefa7b45b26f445d5823b41320e1c572ef6a98f6313f54ce351f818b03cc26e'),
                      title: Text(
                        'Video Title $index',
                        style:  TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                      ),
                      subtitle: const Text('Video Views: 10K'),
                      trailing: const Icon(Icons.arrow_forward),
                    ),
                  );
                },
              ),
              // Files Tab Content
             ListView.builder(
  itemCount: 10, // Adjust the number of file items
  itemBuilder: (context, index) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      elevation: 4,
      child: ListTile(
        onTap: () {},
        contentPadding: const EdgeInsets.all(10),
        leading: Image.network(
          'https://img.freepik.com/free-photo/clipboard-with-checklist-paper-note-icon-symbol-purple-background-3d-rendering_56104-1491.jpg?w=826&t=st=1698135465~exp=1698136065~hmac=cadd6ad00463dcae2be4df14c42d6b256a018d075562de67de8327ad7cadd052', // Replace with the actual file thumbnail URL
          width: 80, // Adjust the thumbnail size as needed
        ),
        title: Text(
          'File Title $index',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: const Text('File Size: 1.5MB'), // You can display file size or other information here
        trailing: const Icon(Icons.arrow_forward),
      ),
    );
  },
),
              // About Tab Content
      Center(
                child:Card(
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
)
           ) ],
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return _tabBar;
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}