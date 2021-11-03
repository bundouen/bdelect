import 'package:bdelect/constants.dart';
import 'package:bdelect/controller/product_category_controller.dart';

import 'package:bdelect/model/product.dart';
import 'package:bdelect/widget/product_detail/panel_header_widget.dart';
import 'package:bdelect/widget/product_detail/product_by_catagory.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PanelWidget extends StatefulWidget {
  final Datum product;
  final VoidCallback onClickedPanel;
  final VoidCallback onClickedAddCart;
  final ProductCategoryController categoryController;

  const PanelWidget({
    required this.product,
    required this.onClickedPanel,
    required this.onClickedAddCart,
    required this.categoryController,
    Key? key,
  }) : super(key: key);

  @override
  State<PanelWidget> createState() => _PanelWidgetState();
}

class _PanelWidgetState extends State<PanelWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: kSecondaryColor,
      ),
      child: buildProfile(),
    );
  }

  Widget buildProfile() {
    return Container(
      // color: kSecondaryColor,
      padding: EdgeInsets.only(
        top: 10,
        left: 10,
        right: 10,
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
                child: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(
                  30,
                ),
              ),
              margin: EdgeInsets.only(
                bottom: 10,
              ),
              height: 4,
              width: 90,
            )),
          ),
          Expanded(
            child: GetBuilder(
              init: widget.categoryController,
              builder: (context) => Stack(children: [
                ListView(
                  controller: widget.categoryController.controller,
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: PanelHeaderWidget(
                        product: widget.product,
                        onClickedAddCart: widget.onClickedAddCart,
                      ),
                    ),
                    Divider(
                      height: 6,
                    ),
                    SizedBox(height: 5),
                    buildProductDetails(widget.product),
                    SizedBox(height: 10),
                    Divider(
                      height: 6,
                      color: Colors.black,
                    ),
                    SizedBox(height: 5),
                    Text(
                      "ប្រភេទដូចគ្នា (${widget.product.category.category})",
                      style: TextStyle(
                        fontFamily: khmerSiemreap,
                        fontSize: 16,
                        package: packageKhmer,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                    ),
                    ProductByCategory(
                      categoryId: widget.product.category.id,
                      productCategoryController: widget.categoryController,
                    ),
                  ],
                ),
                // if (widget.categoryController.isCatLoaded.value)
                //   Positioned(
                //     left: 0,
                //     bottom: 0,
                //     child: Container(
                //       width: 400,
                //       height: 80,
                //       child: Center(
                //         child: CircularProgressIndicator(),
                //       ),
                //     ),
                //   ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProductDetails(Datum product) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "ព៌តមានលម្អិត៖",
            style: TextStyle(
              fontFamily: khmerMoul,
              fontSize: 15,
              color: kPrimaryColor,
              package: packageKhmer,
              // fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text(
            product.productDetail,
            style: TextStyle(
              fontFamily: khmerSiemreap,
              fontSize: 12,
              package: packageKhmer,
            ),
          ),
        ],
      );
}
