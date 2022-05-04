
import 'package:bdelect/screen/product_by_category_screen.dart';
import 'package:bdelect/widget/category/category_item.dart';
import 'package:flutter/material.dart';


import 'package:get/get.dart';


class CategoryView extends StatelessWidget {
  final categoryList;
  CategoryView({required this.categoryList});
  @override
  Widget build(BuildContext context) {
  return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 200,
        // color: Colors.grey[200],
        child: Obx(
          () => (ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoryList.length,
              itemBuilder: (ctxt, i) {
                return InkWell(
                  onTap: () {
                    Get.toNamed(
                      ProductByCategoryScreen.routeName,
                      arguments: categoryList[i].id,
                    );
                  },
                  child: CategoryItem(categoryItem: categoryList[i]),
                );
              })),
        ),
      ),
    );
  }
}


