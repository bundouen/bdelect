import 'package:bdelect/controller/productcontroller.dart';
import 'package:bdelect/screen/product_by_brand_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import 'brand_item.dart';

class BrandView extends StatelessWidget {
  // final BrandController brandController = Get.find<BrandController>();
  final brandList;
  final ProductController controller;
  BrandView(this.brandList, this.controller);

  @override
  Widget build(BuildContext context) {
    // var brandList = brandController.brandList;
    final orientaion = MediaQuery.of(context).orientation;
    return Container(
    
      child: Obx(
        () {
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
              crossAxisCount: 8,
              staggeredTileBuilder: (int index) =>
                  (orientaion == Orientation.portrait
                      ? new StaggeredTile.count(2, 2)
                      : new StaggeredTile.count(1, 1)),
              itemCount: brandList.length,
              itemBuilder: (BuildContext context, int index) => InkWell(
                onTap: () {
                  // id = brandList[index].id;
                  Get.toNamed(
                    ProductByBrandScreen.routeName,
                    arguments:  brandList[index].id,
                  );
                },
                child: BrandItem(
                  brandItem: brandList[index],
                  // khmFonts: khmFonts,
                ),
              ),
            );
        },
      ),
    );
  }
}
