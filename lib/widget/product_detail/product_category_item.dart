import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../model/product.dart';

class ProductCategoryItem extends StatelessWidget {
  const ProductCategoryItem({
    Key? key,
    required this.productList,
    // required this.khmFonts,
  }) : super(key: key);

  final Datum productList;
  // final String khmFonts;

  @override
  Widget build(BuildContext context) {
    double _top;
    if (productList.discount > 0) {
      _top = 26.0;
    } else {
      _top = 10.0;
    }
    return Stack(
      children: [
        Card(
          elevation: 0.0,
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            margin: EdgeInsets.only(top: _top),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    productList.productName,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: khmerSiemreap,
                        package: packageKhmer,
                        color: kPrimaryColor),
                  ),
                ),
                Expanded(
                  // child: Hero(
                  //   tag: productList.id,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      // child: FadeInImage.assetNetwork(
                      //   placeholder: "assets/images/loading.gif",
                      //   image: "http://bdelect.bdaccessory.store/" +
                      //       productList.image,
                      //   fit: BoxFit.cover,
                      // ),
                      child: CachedNetworkImage(
                    // cacheManager: customCacheManager,
                    imageUrl: "http://bdelect.bdaccessory.store/" +
                        productList.image,
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
                // ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        '\$${productList.price * (1 - productList.discount / 100)}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kTextColor,
                            fontFamily: khmerSiemreap,
                            package: packageKhmer),
                      ),
                      // Text(
                      //   productList.discount > 0
                      //       ? '\$${(productList.price)}'
                      //       : "",
                      //   style: TextStyle(
                      //       fontFamily: khmerSiemreap,
                      //       package: packageKhmer,
                      //       decoration: productList.discount > 0
                      //           ? TextDecoration.lineThrough
                      //           : TextDecoration.none,
                      //       color: productList.discount > 0
                      //           ? Colors.red
                      //           : Colors.black12),
                      // ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.shopping_cart),
                        color: Colors.red,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (productList.discount > 0)
          Positioned(
            left: 5,
            top: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              height: 30,
              width: 50,
              child: Center(
                child: Text(
                  "-${productList.discount}%",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: khmerMoul,
                    package: packageKhmer,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 100,
            top: 5,
            child: Text(
                        productList.discount > 0
                            ? '\$${(productList.price)}'
                            : "",
                        style: TextStyle(
                            fontFamily: khmerSiemreap,
                            package: packageKhmer,
                            decoration: productList.discount > 0
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            color: productList.discount > 0
                                ? Colors.red
                                : Colors.black12),
                      ),)
      ],
    );
  }
}
