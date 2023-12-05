import 'package:talentsearchenglish/utils/ColorConstants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../Modals/ChannelListModal.dart';

class SubscriptionModalBottomSheet extends StatelessWidget {
  const SubscriptionModalBottomSheet({super.key, required this.channel});
  final Channels channel;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: CustomColors.primaryColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
      height: MediaQuery.of(context).size.height * 0.55,
      child: LayoutBuilder(builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.lock,
                      size: 20.sp,
                    ),
                    Text(
                      'Locked',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: constraints.maxHeight * 0.03),
                Text(
                  'Access this channel by paying the Subscription fee.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 11.sp),
                ),
                SizedBox(height: constraints.maxHeight * 0.05),
                Text(
                  'Price: ₹${channel.price}',
                  style: TextStyle(fontSize: 10.sp),
                ),
                SizedBox(height: constraints.maxHeight * 0.05),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'You can pay by scanning the below QR code',
                    style: TextStyle(fontSize: 11.sp),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: constraints.maxHeight * 0.05),
                SvgPicture.asset(
                  'assets/TSQrcode.svg',
                  fit: BoxFit.scaleDown,
                  height: constraints.maxHeight * 0.2,
                ),
                SizedBox(height: constraints.maxHeight * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'After making Payment contact - +91 8083547467 to get enrolled!',
                    style: TextStyle(fontSize: 11.sp),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
