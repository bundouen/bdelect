import 'dart:convert';

import 'package:bdelect/model/pname.dart';
import 'package:bdelect/model/product.dart';

import '../repository/repository.dart';
import 'package:get/get.dart';

class ProductService extends GetConnect {
  Repository _repository = Repository();
  ProductService() {
    _repository = Repository();
  }

  Future<Products> getAllProductByPage(int page) async {
    try {
      var response = await _repository.httpGet('product/?page=$page');
      if (response.statusCode == 200) {
        return productsFromJson(response.body);
      } else {
        throw Exception("Fail to load data");
      }
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  Future<Products> getAllProducts() async {
    try {
      var response = await _repository.httpGet('product/all');
      if (response.statusCode == 200) {
        return Products.fromJson(json.decode(response.body));
      } else {
        throw Exception("Fail to load data");
      }
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  Future<Products> getAllProductByCategory(
    int page,
    var catid,
  ) async {
    // http://bdelect.bdaccessory.store/api/product/category/?page=1&catid=20
    try {
      var response = await _repository
          .httpGet("product/category/?page=$page&catid=$catid");
      if (response.statusCode == 200) {
        return Products.fromJson(
          json.decode(
            response.body,
          ),
        );
      } else {
        throw Exception(
          "Fail to load data",
        );
      }
    } catch (exception) {
      return Future.error(
        exception.toString(),
      );
    }
  }

  Future<Products> getAllProductByBrand(
    int page,
    var brandId,
  ) async {
    // http://bdelect.bdaccessory.store/api/product/brand/?page=1&brandid=8
    try {
      var response = await _repository
          .httpGet("product/brand/?page=$page&brandid=$brandId");
      if (response.statusCode == 200) {
        return Products.fromJson(
          json.decode(
            response.body,
          ),
        );
      } else {
        throw Exception(
          "Fail to load data",
        );
      }
    } catch (exception) {
      return Future.error(
        exception.toString(),
      );
    }
  }

  Future<Products> getAllProductByGroup(
    int page,
    var groupid,
  ) async {
    // http://bdelect.bdaccessory.store/api/product/groups/?page=1&groupid=19
    try {
      var response = await _repository
          .httpGet("product/groups/?page=$page&groupid=$groupid");
      if (response.statusCode == 200) {
        return Products.fromJson(
          json.decode(
            response.body,
          ),
        );
      } else {
        throw Exception(
          "Fail to load data",
        );
      }
    } catch (exception) {
      return Future.error(
        exception.toString(),
      );
    }
  }

   Future<PName> getProductByName() async {
    try {
      var response = await _repository.httpGet('product/distinctproduct');
      if (response.statusCode == 200) {
        return PName.fromJson(json.decode(response.body));
      } else {
        throw Exception("Fail to load data");
      }
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }
}
