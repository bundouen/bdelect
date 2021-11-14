import 'package:bdelect/controller/slidercontroller.dart';
import 'package:bdelect/controller/user_controller.dart';

import 'package:flutter/rendering.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/brand/brand_view.dart';
import '../constants.dart';
import '../widget/search_icon.dart';
import '../widget/shopping_cart.dart';
import '../widget/product_by_group/group_product_view.dart';
import '../widget/image_slider_view.dart';
import '../widget/product_view.dart';
import '../controller/productcontroller.dart';

class HomeView extends StatefulWidget {
  static final routName = '/';
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ProductController controller = Get.find<ProductController>();
  final SliderController sliderController = Get.find<SliderController>();
  final UserController userController = Get.find<UserController>();

  double isFabVisible = 0;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    isFabVisible = 0;
    _scrollController = ScrollController();
    _scrollController.addListener(listentController);
    super.initState();
  }

  void listentController() {
    if (_scrollController.position.atEdge) {
      final isTop = _scrollController.position.pixels == 0;
      if (isTop) {
        setState(() {
          isFabVisible = 0;
        });
      } else {
        setState(() {
          isFabVisible = 1;
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    controller.refreshController.dispose();
    userController.dispose();
    super.dispose();
  }

  final ks = "KhmerOSsiemreap";
  @override
  Widget build(BuildContext context) {
    var productList = controller.lstTask;
    var groupList = controller.groupList;
    var brandList = controller.brandList;
    // String csrfToken = userController.csrfTokenData.value;

    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: AppBar(
        title: Text(
          'ផ្សារអេឡិចត្រូនិច',
          // style: TextStyle(color: Colors.red, fontFamily: "KhmerOSmuol"),
          style: TextStyle(
            color: kPrimaryColor,
            fontFamily: khmerMoul,
            fontSize: 22,
            package: packageKhmer,
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
              color: Colors.red,
            ),
          ),
          IconButton(
              onPressed: () {
                userController.getLogOut();
              },
              icon: Icon(
                Icons.logout,
                color: Colors.red,
              ))
        ],
      ),
      body: Container(
        color: kSecondaryColor,
        child: SmartRefresher(
          enablePullUp: true,
          controller: controller.refreshController,
          header: WaterDropHeader(
              waterDropColor: kPrimaryColor,
              complete: Icon(
                Icons.verified,
                color: kBColor,
              )
              // Text(
              //   "ជោគជ័យ",
              //   style: TextStyle(
              //       fontWeight: FontWeight.bold,
              //       fontFamily: ks,
              //       color: Colors.blueAccent),
              // ),
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
                        fontFamily: ks,
                        color: Colors.red[200]));
              }
              return Container(
                height: 55.0,
                child: Center(child: body),
              );
            },
          ),
          onRefresh: () async {
            final result = await controller.fetchProductData(isRefresh: true);
            // final resultGroupBrand = await controller.fetchProductAll();
            // final resultSlider = await sliderController.fechSliders();
            if (result) {
              controller.refreshController.refreshCompleted();
              controller.fetchProductAll();
              sliderController.fechSliders();
            } else {
              controller.refreshController.refreshFailed();
            }
          },
          onLoading: () async {
            final result = await controller.fetchProductData(isRefresh: false);
            if (result) {
              controller.refreshController.loadComplete();
            } else {
              controller.refreshController.loadFailed();
            }
          },
          child: ListView(
            controller: _scrollController,
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: ImageSlider(),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8, left: 8),
                            child: Text(
                              "គ្រុមទំនិញ",
                              style: TextStyle(
                                fontFamily: khmerMoul,
                                package: packageKhmer,
                                fontSize: 14,
                                color: kBColor,
                              ),
                            ),
                          ),
                          GroupProduct(groupList, controller),
                        ],
                      ),
                      Divider(
                        height: 2,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(bottom: 8, left: 8, right: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "ម៉ាកយីហោ",
                              style: TextStyle(
                                fontFamily: khmerMoul,
                                package: packageKhmer,
                                fontSize: 14,
                                color: kBColor,
                              ),
                            ),
                            BrandView(brandList, controller),
                          ],
                        ),
                      ),
                      Divider(
                        height: 2,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      ProductView(
                        controller: controller,
                        productList: productList,
                        khmFonts: khmerSiemreap,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: AnimatedOpacity(
        duration: Duration(seconds: 2),
        opacity: isFabVisible,
        child: Container(
          height: 30,
          child: FloatingActionButton(
            backgroundColor: kPrimaryColor,
            elevation: 0,
            onPressed: () {
              _scrollController.animateTo(
                0,
                duration: Duration(seconds: 1),
                curve: Curves.easeIn,
              );
            },
            child: Icon(
              Icons.arrow_upward,
            ),
          ),
        ),
      ),
    );
  }
}
