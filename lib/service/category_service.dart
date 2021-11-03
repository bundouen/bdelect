import '../model/category.dart';
import '../repository/repository.dart';
class CategoryService {
  Repository _repository = Repository();
  CategoryService() {
    _repository = Repository();
  }
  Future<List<Category>> getCategory() async {
    try {
      var response = await _repository.httpGet('category');
      List<Category> categoryList = [];
      if (response.statusCode == 200) {
        var jsonString = response.body;
        categoryList = categoryFromJson(jsonString);
        return categoryList;
      } else {
        return [];
      }
    } catch (err) {
      throw err;
    }
  }
}
