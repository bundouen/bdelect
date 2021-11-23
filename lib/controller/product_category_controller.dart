import 'package:bdelect/model/product.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../service/product_service.dart';

class ProductCategoryController extends GetxController {
  final categoryId;
  ProductCategoryController({required this.categoryId});
  ProductService _productService = ProductService();
  var productCategory = <Datum>[].obs;
  var productByCaegoryList=<Datum>[].obs;
  var isLoading = true.obs;
  var isCatLoaded = true.obs;
  var curentPage = 1;
  var totalPages = 0;
  final ScrollController controller = ScrollController();

  // final RefreshController refreshController =
  //     RefreshController(initialRefresh: false);
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void onInit() async {
    super.onInit();
    // Fetch Data
    addItems();
    fetchProductCategory();
  }

  addItems() async {
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        curentPage++;

        fetchProductCategory();
        update();
      }
    });
  }

  // Fetch Data
  Future<bool> fetchProductCategory() async {
    var resp = await _productService.getAllProductByCategory(
      curentPage,
      categoryId,
    );

    if (resp.data.length != 0) {
      if (curentPage == 1) {
        productCategory.value = (resp.data);
      } else {
        productCategory.addAll(resp.data);
      }
      totalPages = ((resp.totalRecord - 1) / 10).ceil();
      isCatLoaded(false);
      isLoading(false);
      return true;
    } else {
      print("No Data");
      return false;
    }
  }

   Future<bool> fetchProductByCategoryId({
    bool isRefresh = false,
  }) async {
    if (isRefresh) {
      curentPage = 1;

    } else {
      if (curentPage >= totalPages) {
        refreshController.loadNoData();
        return false;
      }
      curentPage++;
    }

    var resp = await _productService.getAllProductByCategory(
      curentPage,
      categoryId,
    );
    if (resp.data.length != 0) {
      if (curentPage == 1) {
        productByCaegoryList.value = (resp.data);
      } else {
        productByCaegoryList.addAll(resp.data);
      }
      
      totalPages = ((resp.totalRecord - 1) / 10).ceil();
      isLoading(false);

      return true;
    } else {
      print("No data");
      return false;
    }
  }
}
