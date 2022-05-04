
import 'package:bdelect/model/cart.dart';
import 'package:get/get.dart';

import '../repository/repository.dart';

class CartService extends GetConnect {
  Repository _repository = Repository();
  CartService() {
    _repository = Repository();
  }

  Future<bool> addTocart(int? quantity, int? userId, int? productId) async {
    try {
      Map<String, String> hearders = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      };
      Map<String, dynamic> body = {
        "quantity": quantity!,
        "userId": userId!,
        "productId": productId
      };

      var response = await _repository.httpPost(
        'cart/carts',
        hearders,
        body,
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  Future<List<Carts>> getCart(int userId) async {
    try {
      var response = await _repository.httpGet('cart/?userId=$userId');
      if (response.statusCode == 200) {
        return cartsFromJson(response.body);
      } else {
        throw Exception("Fail to load data");
      }
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }
}
