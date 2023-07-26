import 'package:nike_ecommerce_app/data/product.dart';

class CartItemEntity {
  final int cartItemId;
  final ProductEntity product;
  final int count;
  bool deleteButtonLoading = false;

  CartItemEntity.fromJson(Map<String, dynamic> json)
      : cartItemId = json['cart_item_id'],
        product = ProductEntity.fromJson(json['product']),
        count = json['count'];

  static List<CartItemEntity> parseJsonArray(List<dynamic> jsonArray) {
    final List<CartItemEntity> cartItems = [];
    jsonArray.forEach((element) {
      cartItems.add(CartItemEntity.fromJson(element));
    });

    return cartItems;
  }
}
