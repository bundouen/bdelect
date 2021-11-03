import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../service/product_service.dart';
import '../../model/product.dart';

class ProductGroupController extends GetxController {
  final groupId;
  ProductGroupController(this.groupId);
  ProductService _productService = ProductService();
  var productByGroupList = <Datum>[].obs;
  var isLoading = true.obs;
  var curentPage = 1;
  var totalPages = 0;

  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void onInit() async {
    super.onInit();
    // Fetch Data
    // fetchProductByGroup(isRefresh: true);
  }

  // Fetch Data
  Future<bool> fetchProductByGroup({
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

    var resp = await _productService.getAllProductByGroup(
      curentPage,
      groupId,
    );
    if (resp.data.length != 0) {
      if (curentPage == 1) {
        productByGroupList.value = (resp.data);
      } else {
        productByGroupList.addAll(resp.data);
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
