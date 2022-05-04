import '../model/brand.dart';


import '../repository/repository.dart';

class BrandService {
  Repository _repository = Repository();
  BrandService() {
    _repository = Repository();
  }
  Future<List<Brand>> getBrand() async {
    try {
      var response = await _repository.httpGet('brand');
      List<Brand> brandList = [];
      if (response.statusCode == 200) {
        var jsonString = response.body;
        brandList = brandFromJson(jsonString);
        return brandList;
      } else {
        return [];
      }
    } catch (err) {
      throw err;
    }
  }
}
