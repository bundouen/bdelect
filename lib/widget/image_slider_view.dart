import 'package:bdelect/widget/carousel/slider_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../controller/slidercontroller.dart';

class ImageSlider extends StatelessWidget {
  final SliderController sliderController = Get.find<SliderController>();
  static final customCacheManager = CacheManager(
    Config('cutomCacheKey', maxNrOfCacheObjects: 100),
  );

  List<Widget> generateImageTiles() {
    return sliderController.sliderList
        .map(
          (element) => Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin: EdgeInsets.all(8),
            elevation: 0.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              // child: FadeInImage.assetNetwork(
              //   placeholder: "assets/images/indicator.gif",
              //   image: "http://bdelect.bdaccessory.store/" + element.imageUrl,
              //   fit: BoxFit.fitHeight,
              // ),
              child: CachedNetworkImage(
                cacheManager: customCacheManager,
                imageUrl:
                    "http://bdelect.bdaccessory.store/" + element.imageUrl,
                fit: BoxFit.fitHeight,
                width: 1000, //pixel
                placeholder: (context, url) => SliderIndicator(),
                errorWidget: (context, url, error) => Container(
                  color: Colors.black12,
                  child: Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (sliderController.isLoading.value)
          return Center(
            child: CupertinoActivityIndicator(
              animating: true,
              radius: 10,
            ),
          );
        return Stack(
          children: [
            CarouselSlider(
              items: generateImageTiles(),
              options: CarouselOptions(
                enlargeCenterPage: true,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 5),
                aspectRatio: 18 / 6,
              ),
            ),
          ],
        );
      },
    );
  }
}
