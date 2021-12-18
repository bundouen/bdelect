import 'package:bdelect/model/cart.dart';
import 'package:bdelect/service/cart_service.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  CartService _cartService = CartService();
  var isAddedCart = false.obs;
  var cartItems = <Carts>[].obs;

  Future<void> addToCart(int quantity, int userId, int productId) async {
    try {
      var result = await _cartService.addTocart(quantity, userId, productId);
      if (result == true) {
        isAddedCart(true);
      } else {
        isAddedCart(false);
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> fechCarts(int userId) async {
    var carts = await _cartService.getCart(userId);
    if (carts.length != 0) {
      cartItems.value = (carts);
    } else {
      cartItems.value = [];
    }
  }
}
