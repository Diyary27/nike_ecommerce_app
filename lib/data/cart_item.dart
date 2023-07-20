import 'package:nike_ecommerce_app/data/product.dart';

class CartItemEntity {
  final int cartItemId;
  final ProductEntity product;
  final int count;

  CartItemEntity.fromJson(Map<String, dynamic> json)
      : cartItemId = json['cart_item_id'],
        product = ProductEntity.fromJson(json['product']),
        count = json['count'];
}
