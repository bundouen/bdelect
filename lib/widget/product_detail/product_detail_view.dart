import 'package:bdelect/controller/product_category_controller.dart';
import 'package:bdelect/controller/productcontroller.dart';
import 'package:bdelect/widget/icon_button.dart';

import 'package:bdelect/widget/product_detail/panel_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ProductDetails extends StatefulWidget {
  static const routeName = "/product_details";

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final panelController = PanelController();
  var id;

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.find<ProductController>();

    id = Get.arguments;
    var product = productController.fechProductByPk(id);
    final ProductCategoryController categoryController = Get.put(
      ProductCategoryController(
        categoryId: product.categoryId,
      ),
    );
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: iconButton(
            Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ), () {
          Get.back();
        }),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              height: MediaQuery.of(context).size.height * 0.5,
              child: PageView(
                children: product.imagedetails
                    .map(
                      (prodImage) =>
                          // FadeInImage.assetNetwork(
                          //   placeholder: "assets/images/iLoading.gif",
                          //   image: "http://bdelect.bdaccessory.store/" +
                          //       prodImage.image,
                          //   fit: BoxFit.fitWidth,
                          // ),
                          CachedNetworkImage(
                        // cacheManager: customCacheManager,
                        imageUrl: "http://bdelect.bdaccessory.store/" +
                            prodImage.image,
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
                    )
                    .toList(),
              ),
            ),
          ),
          SlidingUpPanel(
            maxHeight: MediaQuery.of(context).size.height * 0.91,
            minHeight: MediaQuery.of(context).size.height * 0.5,
            color: Colors.transparent,
            parallaxEnabled: true,
            panelSnapping: true,
            parallaxOffset: 6.0,
            controller: panelController,
            // panelBuilder: (ScrollController scrollController)=>
            panel: PanelWidget(
              categoryController: categoryController,
              onClickedAddCart: () {},
              onClickedPanel: panelController.open,
              product: product,
            ),

            //  PanelWidget(
            //   scrollController: scrollController,
            //   onClickedAddCart: () {},
            //   // onClickedPanel: panelController.open,
            //   product: product,
            // );
          ),
        ],
      ),
    );
  }
}
