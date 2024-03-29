import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:grad_proj/login/responsive.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({super.key, required this.blobs,});
  final List<String> blobs;

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
@override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    print(widget.blobs);
  }
  final List<String> images = [
    'assets/images/11.jpg',
    'assets/images/12.jpg',
    'assets/images/13.jpg',
    'assets/images/14.jpg',
    'assets/images/15.jpg',
    'assets/images/16.jpg',
    'assets/images/17.jpg',
    'assets/images/18.jpg',
    'assets/images/19.jpg',
  ];
  @override
  Widget build(BuildContext context) {

    return Center(
        child: CarouselSlider(
          items: images.map((String imageUrl) {
            return Container(
              width: 600.0, 
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) {
                    // Handle the error here
                    print('Image loading error: $error');
                    return Text('Error loading image');
                  },
                ),
              ),

              ),
            );
          }).toList(),
          options: CarouselOptions(
            height: Responsive.isDesktop(context)?400:200,
            enlargeCenterPage: true,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 2),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            pauseAutoPlayOnTouch: true,
            aspectRatio: 2.0,
            viewportFraction: Responsive.isDesktop(context)?0.25:0.5,
            onPageChanged: (index, reason) {
              // Callback when the page changes
            },
          ),
        ),
      
    );
  }
}


