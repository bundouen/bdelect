import 'package:bdelect/constants.dart';
import 'package:bdelect/controller/user_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controller/groupcontroller.dart';
import '../controller/product_group_controller.dart';
import '../controller/productcontroller.dart';
import '../widget/category/category_view.dart';
import '../widget/product_by_group_view.dart';
import '../widget/search_icon.dart';
import '../widget/shopping_cart.dart';

class ProductByGroupScreen extends StatefulWidget {
  static const routeName = "/product_by_group_screen";

  @override
  State<ProductByGroupScreen> createState() => _ProductByGroupScreenState();
}

class _ProductByGroupScreenState extends State<ProductByGroupScreen> {
  final ProductController productController = Get.find<ProductController>();
  final GroupController groupController = Get.find<GroupController>();
  final UserController userController = Get.find<UserController>();
  var id = Get.arguments;
  var productByGroup;

  @override
  Widget build(BuildContext context) {
    final ProductGroupController productGroupController =
        Get.put(ProductGroupController(id));
    var productGroup = groupController.fechGroupById(id);
    productController.fechProductByGroupId(id);
    var categoryList = productController.categoryByGroupId;

    productGroupController.fetchProductByGroup(
      isRefresh: true,
    );
    productByGroup = productGroupController.productByGroupList;
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
                  child: Image.network(
                    "http://bdelect.bdaccessory.store/" + productGroup.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              radius: 26,
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text(
                "${productGroup.group}",
                style: TextStyle(
                  fontFamily: khmerMoul,
                  package: packageKhmer,
                  fontSize: 14,
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
          controller: productGroupController.refreshController,
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
            final result = await productGroupController.fetchProductByGroup(
                isRefresh: true);
            if (result) {
              productGroupController.refreshController.refreshCompleted();
            } else {
              productGroupController.refreshController.refreshFailed();
            }
          },
          onLoading: () async {
            final result = await productGroupController.fetchProductByGroup(
                isRefresh: false);
            if (result) {
              productGroupController.refreshController.loadComplete();
            } else {
              productGroupController.refreshController.loadFailed();
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8, left: 8),
                            child: Text(
                              "ប្រភេទទំនិញ",
                              style: TextStyle(
                                fontFamily: khmerMoul,
                                package: packageKhmer,
                                fontSize: 14,
                                color: kBColor,
                              ),
                            ),
                          ),
                          CategoryView(
                            categoryList: categoryList,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Divider(
                        height: 2,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      ProductByGroupView(
                        controller: productGroupController,
                        productList: productByGroup,
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
