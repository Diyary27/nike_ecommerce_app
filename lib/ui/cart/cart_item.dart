import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_ecommerce_app/common/utils.dart';
import 'package:nike_ecommerce_app/data/cart_item.dart';
import 'package:nike_ecommerce_app/ui/widgets/image.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.cartItem,
    required this.onDeleteButtonClick,
  });

  final CartItemEntity cartItem;
  final GestureTapCallback onDeleteButtonClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12.withOpacity(0.05), blurRadius: 2)
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                  height: 100,
                  child:
                      ImageLoadingService(imageUrl: cartItem.product.imageUrl),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(cartItem.product.title),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text('تعداد'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(CupertinoIcons.plus_square)),
                      Text(cartItem.count.toString()),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(CupertinoIcons.minus_square)),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    cartItem.product.previousPrice.withPriceLabel,
                    style: TextStyle(decoration: TextDecoration.lineThrough),
                  ),
                  Text(cartItem.product.price.withPriceLabel),
                ],
              ),
            ],
          ),
          Divider(
            height: 1,
          ),
          cartItem.deleteButtonLoading
              ? const SizedBox(
                  height: 48,
                  child: Center(
                    child: CupertinoActivityIndicator(),
                  ),
                )
              : TextButton(
                  onPressed: onDeleteButtonClick,
                  child: const Text('حذف از سبد خرید'),
                ),
        ],
      ),
    );
  }
}
