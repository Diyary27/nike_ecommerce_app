import 'package:nike_ecommerce_app/data/cart_item.dart';

class CartResponse {
  final List<CartItemEntity> carts;
  final int payablePrice;
  final int totalPrice;
  final int shippingCost;

  CartResponse.fromJson(Map<String, dynamic> json)
      : carts = CartItemEntity.parseJsonArray(json['cart_items']),
        payablePrice = json['payable_price'],
        totalPrice = json['total_price'],
        shippingCost = json['shipping_cost'];
}
