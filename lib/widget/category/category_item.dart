import 'package:bdelect/constants.dart';
import 'package:bdelect/model/category_by_group.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final CategoryByGroup categoryItem;
  const CategoryItem({
    Key? key,
    required this.categoryItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: 40),
          child: Card(
            elevation: 0.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Colors.white,
            child: Container(
              alignment: Alignment.bottomCenter,
              width: 120,
              height: 150,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Title(
                  color: kTextColor,
                  child: Text(
                    categoryItem.name,
                    style: TextStyle(
                      fontFamily: khmerSiemreap,
                      package: packageKhmer,
                      fontSize: 12,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ),
              // height: 180,
            ),
          ),
        ),
        Positioned(
            left: 15,
            child: Container(
              width: 100,
              height: 150,
              child: Padding(
                padding: const EdgeInsets.only(top: 3.0),
                child: Container(
                  width: 90,
                  height: 130,
                  // child: FadeInImage.assetNetwork(
                  //   placeholder: "assets/images/loading.gif",
                  //   image: "http://bdelect.bdaccessory.store/" +
                  //       categoryItem.image,
                  //   fit: BoxFit.cover,
                  // ),
                  child: CachedNetworkImage(
                    // cacheManager: customCacheManager,
                    imageUrl: "http://bdelect.bdaccessory.store/" +
                        categoryItem.image,
                    fit: BoxFit.fitHeight,
                    width: 1000, //pixel
                    placeholder: (context, url) => Image.asset(
                      "assets/images/loading.gif",
                    ),
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
            ))
      ],
    );
  }
}
