import 'package:get/get.dart';
import '../model/brand.dart';

import '../service/brand_service.dart';

class BrandController extends GetxController {
  BrandService _brandService = BrandService();
  var brandList = <Brand>[].obs;
  @override
  void onInit() {
    fechBrands();
    super.onInit();
  }

  fechBrands() async {
    try {
      var brands = await _brandService.getBrand();
      if (brands.length != 0) brandList.addAll(brands);
    } catch (err) {
      throw (err);
    }
  }

  Brand fechBrandById(var id) {
    var _productBrand = brandList.firstWhere(
      (element) => element.id == id,
    );
    return _productBrand;
  }
}
