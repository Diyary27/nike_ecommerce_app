import 'package:flutter/material.dart';
import 'package:nike_ecommerce_app/common/utils.dart';

class PriceInfo extends StatelessWidget {
  final int totalPrice;
  final int shippingCost;
  final int payablePrice;

  PriceInfo(
      {super.key,
      required this.totalPrice,
      required this.shippingCost,
      required this.payablePrice});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(8, 16, 8, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text('جزئیات خرید',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: 20)),
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              boxShadow: [
                BoxShadow(
                    color: Colors.black12.withOpacity(0.05), blurRadius: 2)
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 16, 8, 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('مبلغ کل خرید'),
                      RichText(
                          text: TextSpan(
                              text: totalPrice.separateByComma,
                              style: DefaultTextStyle.of(context)
                                  .style
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                              children: [
                            TextSpan(
                                text: ' تومان',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal)),
                          ])),
                    ],
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('هزینه ارسال'),
                      Text(shippingCost.withPriceLabel),
                    ],
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 6, 8, 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('مبلغ قابل پرداخت'),
                      RichText(
                          text: TextSpan(
                              text: payablePrice.separateByComma,
                              style: DefaultTextStyle.of(context)
                                  .style
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                              children: [
                            TextSpan(
                                text: ' تومان',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal)),
                          ])),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
