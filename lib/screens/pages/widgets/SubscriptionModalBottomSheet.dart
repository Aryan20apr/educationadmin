
import 'package:educationadmin/utils/ColorConstants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../Modals/ChannelListModal.dart';
class SubscriptionModalBottomSheet extends StatelessWidget {
  const SubscriptionModalBottomSheet({super.key,required this.channel});
 final Channels channel;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:const BoxDecoration(color: CustomColors.primaryColor,borderRadius: BorderRadius.only(topLeft:Radius.circular(20.0),topRight: Radius.circular(20.0))),
      height: MediaQuery.of(context).size.height*0.4,
     
      child: LayoutBuilder(
        builder: (context,constraints) {
          return Padding(
            padding: const EdgeInsets.only(top:8.0,left: 8.0,right: 8.0),
            child: Container(
              decoration:const BoxDecoration(color: Colors.white,borderRadius: BorderRadius.only(topLeft:Radius.circular(20.0),topRight: Radius.circular(20.0))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                      Icon(Icons.lock,size: 20.sp,),
                       Text(
                        'Locked',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                     ],
                   ),
                   SizedBox(height: constraints.maxHeight*0.05),
                   Text(
                    'Access this channel by paying the access fee.',textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14.sp),
                  ),
                   SizedBox(height: constraints.maxHeight*0.05),
                   Text(
                    'Price: ₹${channel.price}',
                    style: TextStyle(fontSize: 12.sp),
                  ),
                  SizedBox(height: constraints.maxHeight*0.1),
                  ElevatedButton(
                    onPressed: () {
                      // Add your button functionality here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    child:  Text(
                      'Unlock',
                      style: TextStyle(fontSize: 14.sp,color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}