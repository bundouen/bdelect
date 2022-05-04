import '../model/category.dart';
import '../service/category_service.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  CategoryService _categoryService = CategoryService();
  var categoryList = <Category>[].obs;
  @override
  void onInit() {
    fechCategory();
    super.onInit();
  }

  fechCategory() async {
    try {
      var categories = await _categoryService.getCategory();
      if (categories.length != 0)
        categoryList.addAll(
          categories,
        );
    } catch (err) {
      throw (err);
    }
  }

  Category fechCategoryById(var id) {
    var _productCategory = categoryList.firstWhere(
      (element) => element.id == id,
    );
    return _productCategory;
  }
}
