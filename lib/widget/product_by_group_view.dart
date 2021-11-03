
import 'package:bdelect/model/product.dart';
import 'package:bdelect/widget/product_detail/product_detail_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '/widget/product_item.dart';

class ProductByGroupView extends StatelessWidget {
  const ProductByGroupView({
    Key? key,
    required this.controller,
    required this.productList,
    required this.khmFonts,
  }) : super(key: key);

  final  controller;
  final RxList<Datum> productList;
  final String khmFonts;

  @override
  Widget build(BuildContext context) {
    final orientaion = MediaQuery.of(context).orientation;
    var id;
    return Container(
      child: Obx(() {
        if (controller.isLoading.value)
          return Center(
            child: CupertinoActivityIndicator(
              animating: true,
              radius: 10,
            ),
          );
        else
          return StaggeredGridView.countBuilder(
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: ScrollPhysics(),
            crossAxisCount: 4,
            staggeredTileBuilder: (int index) =>
                (orientaion == Orientation.portrait
                    ? new StaggeredTile.count(2, 3)
                    : new StaggeredTile.count(1, 1.5)),
            itemCount: productList.length,
            itemBuilder: (BuildContext context, int index) => InkWell(
              onTap: () {
                id = productList[index].id;
                Get.toNamed(
                  ProductDetails.routeName,
                  arguments: id,
                );
              },
              child: ProductItem(
                productList: productList[index],
                // khmFonts: khmFonts,
              ),
            ),
          );
      }
          // },
          ),
    );
  }
}
