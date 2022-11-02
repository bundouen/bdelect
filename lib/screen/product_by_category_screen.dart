import 'package:bdelect/constants.dart';
import 'package:bdelect/controller/categoryController.dart';
import 'package:bdelect/controller/product_category_controller.dart';
import 'package:bdelect/controller/user_controller.dart';

import 'package:bdelect/widget/product_by_group_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../widget/search_icon.dart';
import '../widget/shopping_cart.dart';

class ProductByCategoryScreen extends StatefulWidget {
  static const routeName = "/product_by_Categry_screen";

  @override
  State<ProductByCategoryScreen> createState() =>
      _ProductByCategoryScreenState();
}

class _ProductByCategoryScreenState extends State<ProductByCategoryScreen> {
  // var id = Get.arguments;
  final CategoryController categoryController = Get.find<CategoryController>();
  final UserController userController = Get.find<UserController>();
  final ProductCategoryController productCategoryController =
      Get.put(ProductCategoryController(categoryId: Get.arguments));

  @override
  Widget build(BuildContext context) {
    var cagetegoryList = categoryController.fechCategoryById(Get.arguments);
    productCategoryController.fetchProductByCategoryId(isRefresh: true);
    var productByCategoryList = productCategoryController.productByCaegoryList;
    // String csrfToken = userController.csrfTokenData.value;
    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: kSecondaryColor,
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: ClipOval(
                  // child: Image.network(
                  //   "http://bdelect.bdaccessory.store/" +
                  //       cagetegoryList.imageUrl,
                  //   fit: BoxFit.cover,
                  // ),
                  child: CachedNetworkImage(
                    // cacheManager: customCacheManager,
                    imageUrl: "http://bdelect.bdaccessory.store/" +
                        cagetegoryList.imageUrl,
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
              radius: 26,
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text(
                "${cagetegoryList.category}",
                style: TextStyle(
                  fontFamily: khmerMoul,
                  package: packageKhmer,
                  fontSize: 12,
                  color: kBColor,
                ),
              ),
            )
          ],
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: kBColor,
          ),
        ),
        actions: [
          seachIcon(
            Icon(
              Icons.search,
              color: Colors.amber,
            ),
          ),
          shoppingCartIcon(
            Icon(
              Icons.shopping_cart,
              color: Colors.blue,
            ),
          ),
        ],
      ),
      body: Container(
        color: kSecondaryColor,
        child: SmartRefresher(
          enablePullUp: true,
          controller: productCategoryController.refreshController,
          header: WaterDropHeader(
            waterDropColor: kPrimaryColor,
            complete: Icon(
              Icons.verified,
              color: kBColor,
            ),
          ),
          // header: WaterDropMaterialHeader(),
          footer: CustomFooter(
            builder: (BuildContext context, LoadStatus? mode) {
              Widget body;
              if (mode == LoadStatus.loading) {
                body = CupertinoActivityIndicator();
              } else if (mode == LoadStatus.failed) {
                body = Text(
                  "អរគុណច្រើន",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: khmerSiemreap,
                      package: packageKhmer,
                      color: kPrimaryColor),
                );
              } else {
                body = Text("",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: khmerSiemreap,
                        package: packageKhmer,
                        color: Colors.red[200]));
              }
              return Container(
                height: 55.0,
                child: Center(child: body),
              );
            },
          ),
          onRefresh: () async {
            final result = await productCategoryController
                .fetchProductByCategoryId(isRefresh: true);
            if (result) {
              productCategoryController.refreshController.refreshCompleted();
            } else {
              productCategoryController.refreshController.refreshFailed();
            }
          },
          onLoading: () async {
            final result = await productCategoryController
                .fetchProductByCategoryId(isRefresh: false);
            if (result) {
              productCategoryController.refreshController.loadComplete();
            } else {
              productCategoryController.refreshController.loadFailed();
            }
          },
          child: ListView(
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      ProductByGroupView(
                        controller: productCategoryController,
                        productList: productByCategoryList,
                        khmFonts: khmerSiemreap,
                      ),
                    ],
                  ),
                ),
              )
            ],
            // ),
          ),
        ),
      ),
    );
  }
}
