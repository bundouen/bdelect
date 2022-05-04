import 'package:bdelect/constants.dart';
import 'package:bdelect/model/product_brand.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

class BrandItem extends StatelessWidget {
  final ProductBrand brandItem;
  const BrandItem({
    Key? key,
    required this.brandItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 200,
      width: 200,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Container(
                width: 60,
                height: 60,
                // child: FadeInImage.assetNetwork(
                //   placeholder: "assets/images/loading.gif",
                //   image: "http://bdelect.bdaccessory.store/" + brandItem.image,
                //   fit: BoxFit.fitWidth,
                // ),
                child: CachedNetworkImage(
                  // cacheManager: customCacheManager,
                  imageUrl:
                      "http://bdelect.bdaccessory.store/" + brandItem.image,
                  fit: BoxFit.fitWidth,
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
            Center(
              child: Text(
                '${brandItem.brand}',
                style: TextStyle(
                  fontFamily: khmerSiemreap,
                  package: packageKhmer,
                  fontSize: 12,
                  color: kPrimaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
