import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class DefaultCarousel extends StatelessWidget {
  const DefaultCarousel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
    
      options: CarouselOptions(
    
          height: Get.height*0.25,
    
          aspectRatio: 16/9,
    
          viewportFraction: 0.80,
    
          initialPage: 0,
    
          enableInfiniteScroll: true,
    
          reverse: false,
    
          autoPlay: true,
    
          autoPlayInterval: const Duration(seconds: 3),
    
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
    
          autoPlayCurve: Curves.fastOutSlowIn,
    
          enlargeCenterPage: true,
    
          enlargeFactor: 0.3,
    
         //
    
          scrollDirection: Axis.horizontal,
    
       ),
    
      itemCount: 3,
    
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
    
        Container(
    
          height: Get.height * 0.25,
    
          decoration: const BoxDecoration(
    
            borderRadius: BorderRadius.all(Radius.circular(10)),
    
            // image: DecorationImage(
    
            //   image: AssetImage('assets/default_image.png'),
    
            //   fit: BoxFit.cover,
    
            // ),
    
            
    
          ),
    
          child: Image.asset('assets/default_image.png')
    
        ),
    
    //                         
    
                          );
  }
}