import 'package:bdelect/model/product_brand.dart';
import 'package:bdelect/model/product_group.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../service/product_service.dart';
import '../../model/product.dart';
import '../model/category_by_group.dart';

class ProductController extends GetxController {
  ProductService _productService = ProductService();
  var lstTask = <Datum>[].obs;
  var productAll = <Datum>[].obs;
  var productByGroupId = <Datum>[].obs;
  var categoryByGroupId = <CategoryByGroup>[].obs;
  var productByName = <Datum>[].obs;
  var groupList = <ProductGroup>[].obs;
  var brandList = <ProductBrand>[].obs;
  var box = GetStorage();

  var product;
  var isLoading = true.obs;
  var curentPage = 1;
  var totalPages = 0;
  var isLoadedProdName = true.obs;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void onInit() async {
    super.onInit();
    // Fetch Data
    fetchProductData(isRefresh: true);
    fetchProductAll();
    if (box.read('allProduct') != null) {
      productAll.assignAll(box.read('allProduct'));
    }
    super.onInit();
    // fetchProductCategoryByGroupId();
  }

  // Fetch Data
  Future<bool> fetchProductData({bool isRefresh = false}) async {
    if (isRefresh) {
      curentPage = 1;
      isLoading(true);
    } else {
      if (curentPage >= totalPages) {
        refreshController.loadNoData();
        return false;
      }
      curentPage++;
    }

    var resp = await _productService.getAllProductByPage(curentPage);
    if (resp.data.length != 0) {
      if (curentPage == 1) {
        lstTask.value = (resp.data);
      } else {
        lstTask.addAll(resp.data);
      }
      totalPages = ((resp.totalRecord - 1) / 10).ceil();
      isLoading(false);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> fetchProductAll() async {
    groupList.clear();
    brandList.clear();
    var resp = await _productService.getAllProducts();

    if (resp.data.length != 0) {
      productAll.assignAll(resp.data);
      box.write("allProduct", resp.data);
      if (productAll.length > 0) {
        productAll.forEach(
          (proGroup) {
            var groups = ProductGroup(0, "", "");
            groups.id = proGroup.group.id;
            groups.group = proGroup.group.group.toString();
            groups.image = proGroup.group.imageUrl.toString();
            if (checkDuplicateGroup(proGroup.group.id) == false)
              groupList.add(groups);
          },
        );

        productAll.forEach(
          (proBrand) {
            var brands = ProductBrand(0, "", "");
            brands.id = proBrand.brand.id;
            brands.brand = proBrand.brand.title.toString();
            brands.image = proBrand.brand.imageUrl.toString();
            if (checkDuplicateBrand(proBrand.brand.id) == false)
              brandList.add(brands);
          },
        );

        return true;
      } else {
        return false;
      }
    } else {
      print("No Data");
      return false;
    }
  }

  Datum fechProductByPk(int id) {
    var _product = productAll.firstWhere(
      (element) => element.id == id,
    );
    return _product;
  }

  fechProductByGroupId(int gid) {
    if (productAll.length != 0) {
      var productGroup = productAll.where((pro) => pro.groupId == gid).toList();
      productByGroupId.clear();
      categoryByGroupId.clear();
      if (productGroup.length != 0) {
        productByGroupId.addAll(productGroup);
        // return true;
      }
      if (productByGroupId.length > 0) {
        productByGroupId.forEach(
          (product) {
            var categGroup = CategoryByGroup(0, "", "");
            categGroup.id = product.category.id;
            categGroup.name = product.category.category.toString();
            categGroup.image = product.category.imageUrl.toString();
            if (checkDuplicateCategory(product.categoryId) == false)
              categoryByGroupId.add(categGroup);
          },
        );
      }
    }
  }

  fechProductByName(String prodName) {
    if (productAll.length != 0) {
      isLoading(true);
      var productNameList =
          productAll.where((pro) => pro.productName == prodName).toList();
      productByName.clear();
      if (productNameList.length != 0) {
        productByName.addAll(productNameList);
        isLoadedProdName(false);
      }
    }
  }

  bool checkDuplicateCategory(int id) {
    bool b = false;
    List<CategoryByGroup> cate = categoryByGroupId
        .where(
          (e) => e.id == id,
        )
        .toList();
    if (cate.length > 0) {
      b = true;
    }
    return b;
  }

  bool checkDuplicateGroup(int id) {
    bool b = false;
    List<ProductGroup> group = groupList
        .where(
          (e) => e.id == id,
        )
        .toList();
    if (group.length > 0) {
      b = true;
    }
    return b;
  }

  bool checkDuplicateBrand(int id) {
    bool b = false;
    List<ProductBrand> brand = brandList
        .where(
          (e) => e.id == id,
        )
        .toList();
    if (brand.length > 0) {
      b = true;
    }
    return b;
  }
}
