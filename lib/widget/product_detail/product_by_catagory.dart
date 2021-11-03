import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';

import '/widget/product_detail/product_category_item.dart';
import '/widget/product_detail/product_detail_view.dart';
import '../../controller/product_category_controller.dart';
import '../../model/product.dart';

class ProductByCategory extends StatefulWidget {
  final categoryId;
  final ProductCategoryController productCategoryController;
  const ProductByCategory({
    Key? key,
    required this.categoryId,
    required this.productCategoryController,
  }) : super(key: key);

  @override
  State<ProductByCategory> createState() => _ProductByCategoryState();
}

class _ProductByCategoryState extends State<ProductByCategory> {
  // ProductCategoryController categoryController =
  //     Get.find<ProductCategoryController>();

  @override
  Widget build(BuildContext context) {
    List<Datum> productListCategory = [];
    var id;
    final orientaion = MediaQuery.of(context).orientation;

    productListCategory = widget.productCategoryController.productCategory;

    return Obx(
      () {
        if (widget.productCategoryController.isLoading.value)
          return Center(
            child:CupertinoActivityIndicator(
              animating: true,
              radius: 10,
            ),
          );
        else
          return StaggeredGridView.countBuilder(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: ScrollPhysics(),
            crossAxisCount: 4,
            staggeredTileBuilder: (int index) =>
                (orientaion == Orientation.portrait
                    ? new StaggeredTile.count(2, (index % 6 == 0) ? 2.5 : 3)
                    : new StaggeredTile.count(1, 1.25)),
            itemCount: productListCategory.length,
            itemBuilder: (BuildContext context, int index) => InkWell(
              onTap: () {
                id = productListCategory[index].id;
                Get.offAndToNamed(
                  ProductDetails.routeName,
                  arguments: id,
                );
              },
              child: ProductCategoryItem(
                productList: productListCategory[index],
                // khmFonts: khmFonts,
              ),
            ),
          );
      },
    );
  }
}
