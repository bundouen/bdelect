import 'package:bdelect/constants.dart';
import 'package:bdelect/model/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductByNameItem extends StatelessWidget {
  const ProductByNameItem({
    Key? key,
    required this.productNameList,
  }) : super(key: key);

  final Datum productNameList;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kSecondaryColor,
      child: Container(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white),
                padding: EdgeInsets.all(10),
                child: CachedNetworkImage(
                  // cacheManager: customCacheManager,
                  imageUrl: imagePath + productNameList.image,
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
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productNameList.productName,
                    style: TextStyle(
                      fontFamily: khmerSiemreap,
                      package: packageKhmer,
                      fontSize: 14,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "កូដទំនិញ៖ " + productNameList.productCode,
                    style: TextStyle(
                      fontFamily: khmerSiemreap,
                      package: packageKhmer,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '\$ ${productNameList.price}',
                    style: TextStyle(
                      fontFamily: khmerSiemreap,
                      package: packageKhmer,
                      fontSize: 16,
                      color: kBColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.add_shopping_cart,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
